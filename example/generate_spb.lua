local root = ".."
package.path =  root.."/lualib/?.lua;"
package.cpath = root.."/luaclib/?.dll;"

local sprotodump = require "sprotodump"

local dump = sprotodump()
dump:set_dump_path("./")
dump:load("./", true)
dump:dump("protocol.spb")


dump:set_dump_file("protocol.txt")
dump:dump("protocol.txt", true)
