.PHONY: test init clean

init: lua_modules

lua_modules:
	@echo "getting lua_modules"
	luarocks install --tree lua_modules luasocket
	luarocks install --tree lua_modules busted
test: lua_modules
	lua_modules/bin/busted test_commands.lua --helper=set_paths

clean:
	@echo "Cleaning"
	rm -rf lua_modules