//
// Created by Borchers, Henry Samuel on 11/20/17.
//

#ifndef VISSERVER_PACKETS_H
#define VISSERVER_PACKETS_H


#include "packet.pb.h"

packet unpack_packet(std::istream &raw_data);

//packet generate_packet();

#ifdef LUA_MODULE
#include "lua.hpp"
extern "C" {
int luaopen_packets(lua_State *L);
}
#endif

#endif //VISSERVER_PACKETS_H
