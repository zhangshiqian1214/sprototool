# sprototool
this project can make and build sproto in windows, sproto build to binary need lpeg library

# for build, you need use visual studio 2013 or higher
click sprototool.sln and build

# build finish, then generate spb
```bash
# cd example
# lua53.exe generate_spb.lua
```

#you can use in your project
```lua
local sproto = require "sproto"
local sprotoloader = require "sprotoloader"

local f = assert(io.open("protocol.spb", "rb"), "Can't open sproto file")
local binary = f:read "*all"
f:close()
sprotoloader.save(binary, 1)
local sp = sprotoloader.load(1)

local proto = sp:host("Package")
local request = proto:attach(sp)
local bytes = request("foobar", {what="here is a boy, is your friends", boy={name="Bob", id=33333, email="bob@google.com"}}
local type, name, request, response = proto:dispatch(bytes)
print(type, name, request, response)
```