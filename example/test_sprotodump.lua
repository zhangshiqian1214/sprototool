local root = ".."
package.path =  root.."/lualib/?.lua;"
package.cpath = root.."/luaclib/?.dll;"

local sprotodump = require "sprotodump"

local dump = sprotodump()
dump:set_dump_path(root.."/proto/")
dump:load(root.."/proto/", true)
dump:dump("protocol.spb")


dump:set_dump_file("protocol.txt")
dump:dump("protocol.txt", true)
