local ast = require "titan-compiler.ast"
local ast_iterator = require "titan-compiler.ast_iterator"
local checker = require "titan-compiler.checker"
local typedecl = require "titan-compiler.typedecl"

local upvalues = {}

local analyze_upvalues

-- This pass analyzes what variables each Titan function needs to have
-- accessible via upvalues. Those upvalues could be module varibles, string
-- literals and records metatables.
--
-- At the moment we store this global data in a single flat table and keep a
-- reference to it as the first upvalue to all the Titan closures in a module.
-- While a titan function is running, the topmost function in the Lua stack
-- (L->func) will be the "lua entry point" of the first Titan function called
-- by Lua, which is also from the same module and therefore also has a reference
-- to this module's upvalue table.
--
-- This pass sets the following fields in the AST:
--
-- _upvalues:
--     In Program node
--     List of Toplevel AST value nodes (Var, Func and Record).
--
-- _literals:
--     In Program node
--     Map a literal to an upvalue.
--
-- _upvalue_index:
--     In Toplevel value nodes
--     Integer. The index of this node in the _upvalues array.
function upvalues.analyze(filename, input)
    local prog, errors = checker.check(filename, input)
    if not prog then return false, errors end
    analyze_upvalues(prog)
    return prog, errors
end

local function declare_type(typename, cons)
    typedecl.declare(upvalues, "upvalues", typename, cons)
end

declare_type("T", {
    Literal = {"lit"},
    ModVar  = {"tl_node"},
})

upvalues.internal_literals = {
    "__index",
    "__newindex",
    "__metatable",
}

local function toplevel_is_value_declaration(tlnode)
    local tag = tlnode._tag
    if     tag == ast.Toplevel.Func then
        return true
    elseif tag == ast.Toplevel.Var then
        return true
    elseif tag == ast.Toplevel.Record then
        return true -- metametable
    elseif tag == ast.Toplevel.Import then
        return false
    else
        error("impossible")
    end
end

local function add_literal(upvs, literals, lit)
    local n = #upvs + 1
    upvs[n] = upvalues.T.Literal(lit)
    literals[lit] = n
end

local analyze = ast_iterator.new()

analyze_upvalues = function(prog)
    local upvs = {}
    local literals = {}

    -- We add internals first because other user values might need them during
    -- initalization
    for _, lit in pairs(upvalues.internal_literals) do
        add_literal(upvs, literals, lit)
    end

    for _, tlnode in ipairs(prog) do
        if toplevel_is_value_declaration(tlnode) then
            local n = #upvs + 1
            tlnode._upvalue_index = n
            upvs[n] = upvalues.T.ModVar(tlnode)
        end
    end

    analyze:Program(prog, upvs, literals)

    prog._upvalues = upvs
    prog._literals = literals
end

function analyze:Type(typ, upvs, literals)
    local tag = typ._tag
    if     tag == ast.Type.LuaRecord then
        for _, field in ipairs(typ.field_decls) do
            add_literal(upvs, literals, field.name)
        end

    else
        ast_iterator.Type(self, typ, upvs, literals)
    end
end

function analyze:Exp(exp, upvs, literals)
    local tag = exp._tag
    if     tag == ast.Exp.String then
        add_literal(upvs, literals, exp.value)

    else
        ast_iterator.Exp(self, exp, upvs, literals)
    end
end

return upvalues
