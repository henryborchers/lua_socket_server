//
// Created by Borchers, Henry Samuel on 11/20/17.
//
#include "catch.hpp"
#include "packets.h"

TEST_CASE("command"){
    std::stringstream data(std::stringstream::out | std::stringstream::in | std::stringstream::binary);

    packet original_packet;
    original_packet.set_command("help");
    {
        auto &args = *original_packet.mutable_args();
        Arg verbose;
        verbose.set_bvalue(true);
        args["verbose"] = verbose;
    }
    original_packet.SerializeToOstream(&data);

    packet packet_decoded = unpack_packet(data);
    REQUIRE(packet_decoded.command() == "help");
    auto &args = packet_decoded.args();
    REQUIRE(args.at("verbose").bvalue());
}