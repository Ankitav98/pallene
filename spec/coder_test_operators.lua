-- Used in checker_spec

local coder_test_operators = {}

local values = {
    ["boolean"] = { true, false },
    ["integer"] = {
        math.mininteger, -10, -3, -2, -1, 0, 1, 2, 3, 10, math.maxinteger,
    },
    ["float"] = {
        -math.huge, -2.0, -1.0, 0.0, 1.0, math.pi, math.huge,
    },
    ["string"] = {
        "",
        "hello",
        "c\0d",
        "ABCDEFGHIJKLMNOPQRSTabcdefghilklmnopqrst", -- long string >= 40 chars
    },
}

local function isnan(x)
    return x ~= x
end

local function are_same(a, b)
    return (a == b) or (isnan(a) and isnan(b))
end

local function check(f_lua, f_pallene, ...)
    local ok_lua,   r_lua   = pcall(f_lua, ...)
    local ok_pallene, r_pallene = pcall(f_pallene, ...)
    if ok_lua ~= ok_pallene then
        return false, string.format("lua %s but pallene %s",
            (ok_lua   and "didn't crash" or "crashed"),
            (ok_pallene and "didn't crash" or "crashed"))
    end
    if ok_lua and ok_pallene and not are_same(r_lua, r_pallene) then
        return false, string.format("(lua: %s, pallene: %s)",
            tostring(r_lua), tostring(r_pallene))
    end
    return true
end

function coder_test_operators.check_unop(op_str, f_lua, f_pallene, typ1)
    for _, x in ipairs(values[typ1]) do
        local ok, err = check(f_lua, f_pallene, x)
        if not ok then
            error(string.format("%s %s: %s",
                op_str, tostring(x), err))
        end
    end
end

function coder_test_operators.check_binop(op_str, f_lua, f_pallene, typ1, typ2)
    for _, x in ipairs(values[typ1]) do
        for _, y in ipairs(values[typ2]) do
            local ok, err = check(f_lua, f_pallene, x, y)
            if not ok then
                error(string.format("%s %s %s: %s",
                    tostring(x), op_str, tostring(y), err))
            end
        end
    end
end

return coder_test_operators
