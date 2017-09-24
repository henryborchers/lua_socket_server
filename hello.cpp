//
// Created by Borchers, Henry Samuel on 9/23/17.
//

#include <iostream>

extern "C" {
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

}

using namespace std;

int main(int argc, char *argv[]) {
    cout << "Hello World\n";
    lua_State *L = luaL_newstate();

    cout << "All done\n";
    return 0;
}