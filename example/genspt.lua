require "common"
local args = {...}
if not args[1] then return print("src not exist") end 
if not args[2] then return print("des not exist") end
require("sprotodump")(args[1], args[2])