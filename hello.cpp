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
    luaL_openlibs(L);
    int ret;
    if((ret = luaL_dofile(L, "share/myserver/set_paths.lua")) != 0){
        cerr << lua_tostring(L, -1) << endl;
        return ret;
    };
    if((ret = luaL_dofile(L, "share/myserver/main.lua")) != 0){
        cerr << lua_tostring(L, -1) << endl;
        return ret;
    };

    lua_close(L);

    cout << "All done\n";
    return 0;
}