require "common"

local sprotodump = require "sprotodump"

local dump = sprotodump()
dump:set_dump_path(root.."/proto/")
dump:load(root.."/proto/", true)
dump:dump("protocol.spb")