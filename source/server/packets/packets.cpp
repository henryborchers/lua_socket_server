//
// Created by Borchers, Henry Samuel on 11/20/17.
//

#include <iostream>
#include "packets.h"

packet unpack_packet(std::istream &raw_data) {

    packet p = packet();
    p.ParseFromIstream(&raw_data);
    return p;
}


#ifdef LUA_MODULE

int get_packet(lua_State *L) {
    if (lua_gettop(L) != 1) {
        return luaL_error(L, "Expected exactly argument");
    }
    luaL_checktype(L, 1, LUA_TUSERDATA);

    packet p = packet();
    void *data = lua_touserdata(L, 1);
    size_t  size =lua_rawlen(L, 1);
    p.ParseFromArray(data, (int)size);

    lua_newtable(L);

    lua_pushstring(L, p.command().c_str());
    lua_setfield(L, -2, "command");

    lua_newtable(L);

    for (auto &arg: p.args()) {
        switch (arg.second.myArg_case()) {
            case Arg::kBvalue:
                lua_pushboolean(L, arg.second.bvalue());
                break;
            case Arg::kSvalue:
                lua_pushstring(L, arg.second.svalue().c_str());
                break;
            case Arg::MYARG_NOT_SET:
                lua_pushnil(L);
                break;
        }
        lua_setfield(L, -2, arg.first.c_str());
    }

    lua_setfield(L, -2, "args");

    return 1;
}

int create_packet(lua_State *L) {
    if (lua_gettop(L) != 1) {
        return luaL_error(L, "Expected exactly argument");
    }
    luaL_checktype(L, 1, LUA_TTABLE);

    packet pack = packet();

    lua_getfield(L, 1, "command");
    lua_getfield(L, 1, "args");
    const char *command = luaL_checkstring(L, -2);
    lua_pushnil(L);
    pack.set_command(command);
    auto &args = *pack.mutable_args();
    while (lua_next(L, -2) != 0) {
        Arg arg;
        if (lua_isstring(L, -1)) {
            arg.set_svalue(lua_tostring(L, -1));
        } else if (lua_isboolean(L, -1)) {
            arg.set_bvalue((bool) lua_toboolean(L, -2));
        } else {
            return luaL_error(L, "Invalid type");
        }
        args[lua_tostring(L, -2)] = arg;
        lua_pop(L, 1);
    }

    int data_size = pack.ByteSize();
    void *buffer = lua_newuserdata(L, (size_t)data_size);
    pack.SerializeToArray(buffer, data_size);
    return 1;
}

int luaopen_packets(lua_State *L) {

    luaL_Reg fns[] = {
            {"create_packet", create_packet},
            {"get_packet",    get_packet},
            {nullptr, nullptr},
    };
    luaL_newlib(L, fns);
    return 1;
}

#endif