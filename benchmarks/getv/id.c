/* This file was generated by the Titan compiler. Do not edit by hand */
/* Indentation and formatting courtesy of titan-compiler/pretty.lua */

#include <string.h>

#include "tcore.h"

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#include "lapi.h"
#include "lfunc.h"
#include "lgc.h"
#include "lobject.h"
#include "lstate.h"
#include "lstring.h"
#include "ltable.h"
#include "lvm.h"

#include "math.h"

static Table * function_new_titan(
    lua_State * L,
    lua_Number x1 /* v */
){
    CClosure * x2 = clCvalue(s2v(L->ci->func));
    Table * x3 /* upvalue table */ = hvalue(&x2->upvalue[0]);
    TValue * x4 /* upvalue array */ = x3->array;
    (void)x4;
    {
        luaC_condGC(L, {
        }, {
        });
        Table * x5 = luaH_new(L);
        luaH_resize(L, x5, 0, 1);
        TValue * x6 =  &x4[6] ;
        TString * x7 = tsvalue(x6);
        TValue x8;
        setsvalue(L, &x8, x7);
        TValue * x9 = luaH_newkey(L, x5, &x8);
        setfltvalue(x9, x1);
        return x5;
    }
}

static int function_new_lua(lua_State *L)
{
    lua_checkstack(L, 1);
    CClosure * x1 = clCvalue(s2v(L->ci->func));
    Table * x2 /* upvalue table */ = hvalue(&x1->upvalue[0]);
    TValue * x3 /* upvalue array */ = x2->array;
    (void)x3;
    StackValue* x4 = L->ci->func;
    int x5 /* nargs */ = cast_int(L->top - (x4 + 1));
    if (TITAN_UNLIKELY(x5 != 1)) {
        titan_runtime_arity_error(L, 1, x5);
    }
    TValue* x6 = s2v(x4 + 1);
    if (TITAN_UNLIKELY(!ttisfloat(x6))) {
        titan_runtime_argument_type_error(L, "v", 1, LUA_TNUMFLT, x6);
    }
    lua_Number x7 = fltvalue(s2v(x4 + 1));
    Table * x8 /* ret */ = function_new_titan(L, x7);
    sethvalue(L, s2v(L->top), x8);
    api_incr_top(L);
    return 1;
}

static int function_v_lua(lua_State *L)
{
    lua_checkstack(L, 1);
    return 1;
}

int luaopen_benchmarks_getv_id(lua_State *L)
{
    lua_checkstack(L, 4);
    /* Allocate upvalue table */
    /* ---------------------- */
    Table * x1 = luaH_new(L);
    luaH_resizearray(L, x1, 7);
    TValue * x2 = x1->array;
    /* Initialize upvalues */
    /* ------------------- */
    TString * x3 = luaS_new(L, "__index");
    setsvalue(L,  &x2[0] , x3);
    if (isblack(obj2gco(x1)) && iswhite(obj2gco(x3))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    TString * x4 = luaS_new(L, "__newindex");
    setsvalue(L,  &x2[1] , x4);
    if (isblack(obj2gco(x1)) && iswhite(obj2gco(x4))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    TString * x5 = luaS_new(L, "__metatable");
    setsvalue(L,  &x2[2] , x5);
    if (isblack(obj2gco(x1)) && iswhite(obj2gco(x5))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    /* new */
    CClosure* x6 = luaF_newCclosure(L, 1);
    x6->f = function_new_lua;
    sethvalue(L, &x6->upvalue[0], x1);
    TValue x7; setclCvalue(L, &x7, x6);
    setobj(L,  &x2[3] , &x7);
    if (iscollectable(&x7) && isblack(obj2gco(x1)) && iswhite(gcvalue(&x7))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    /* v */
    CClosure* x8 = luaF_newCclosure(L, 1);
    x8->f = function_v_lua;
    sethvalue(L, &x8->upvalue[0], x1);
    TValue x9; setclCvalue(L, &x9, x8);
    setobj(L,  &x2[4] , &x9);
    if (iscollectable(&x9) && isblack(obj2gco(x1)) && iswhite(gcvalue(&x9))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    TString * x10 = luaS_new(L, "v");
    setsvalue(L,  &x2[5] , x10);
    if (isblack(obj2gco(x1)) && iswhite(obj2gco(x10))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    TString * x11 = luaS_new(L, "v");
    setsvalue(L,  &x2[6] , x11);
    if (isblack(obj2gco(x1)) && iswhite(obj2gco(x11))) {
        luaC_barrierback_(L, obj2gco(x1));
    }
    /* Create exports table */
    /* -------------------- */
    StackValue* x12 = L->top;
    sethvalue(L, s2v(x12), x1); x12++;
    L->top = x12;
    lua_createtable(L, 0, 2);
    lua_pushstring(L, "new");
    setobj(L, s2v(L->top),  &x2[3] ); api_incr_top(L);
    lua_settable(L, -3);
    lua_pushstring(L, "v");
    setobj(L, s2v(L->top),  &x2[4] ); api_incr_top(L);
    lua_settable(L, -3);
    return 1;
}

