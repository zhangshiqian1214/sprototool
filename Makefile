LUA_CLIB_PATH ?= luaclib
LUA_INC ?= lua53/src
CC ?= gcc

SHARED := -fPIC --shared
CFLAGS = -g -O2 -Wall -I$(LUA_INC) $(MYCFLAGS)
LUA_CLIB = lpeg sproto lfs
PLAT = linux

all : $(foreach v, $(LUA_CLIB), $(LUA_CLIB_PATH)/$(v).so)

$(LUA_CLIB_PATH)/lpeg.so : lpeg/lpcap.c lpeg/lpcode.c lpeg/lpprint.c lpeg/lptree.c lpeg/lpvm.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) -Ilpeg $^ -o $@

$(LUA_CLIB_PATH)/sproto.so : sproto/sproto.c sproto/lsproto.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) -Isproto $^ -o $@

$(LUA_CLIB_PATH)/lfs.so : luafilesystem/src/lfs.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) -Isproto $^ -o $@

clean:
	rm -f $(LUA_CLIB_PATH)/*.so
