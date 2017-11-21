//
// Created by Borchers, Henry Samuel on 11/20/17.
//

#include "packets.h"


packet unpack_packet(std::istream &raw_data) {

    packet p = packet();
    p.ParseFromIstream(&raw_data);
    return p;
}
