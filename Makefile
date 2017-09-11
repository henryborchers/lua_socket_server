.PHONY: test init clean

init: build

build: lua_modules startserver.sh

lua_modules:
	@echo "getting lua_modules"
	luarocks install --tree lua_modules luasocket
	luarocks install --tree lua_modules busted

startserver.sh:
	@echo "#!/usr/bin/env bash" 				>  startserver.sh
	@echo "lua -l set_paths source/main.lua" 	>> startserver.sh
	@chmod +x startserver.sh

test: lua_modules
	lua_modules/bin/busted tests/test_commands.lua --helper=set_paths

clean:
	@rm -rf lua_modules
	@rm -f startserver.sh
