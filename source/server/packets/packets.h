//
// Created by Borchers, Henry Samuel on 11/20/17.
//

#ifndef VISSERVER_PACKETS_H
#define VISSERVER_PACKETS_H

#include "packet.pb.h"

packet unpack_packet(std::istream &raw_data);
//packet decode_packet(std::stringstream &stringstream);
#endif //VISSERVER_PACKETS_H
