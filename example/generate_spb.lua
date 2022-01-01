local root = ".."
package.path =  root.."/lualib/?.lua;"
package.cpath = root.."/luaclib/?.dll;"

local sprotodump = require "sprotodump"

local dump = sprotodump()
dump:set_dump_path("./")


-- dump:set_sproto_path("./")
-- dump:dump("protocol.spb")

dump:set_sproto_path("../proto")
dump:dump("all.spb")