local root    = "../"
package.path  = root .. "lualib/?.lua;"
package.cpath = root .. "luaclib/?.dll;"

local protoPrefix = root .. "spb/"
local spbPrefix   = root .. "spb/"
local parser      = require "sprotoparser"

local function GenerateBinary(files, outfile)
	local output = ""
	for _, v in pairs(files) do
		local filename = protoPrefix .. v
		local f = assert(io.open(filename), "Can't open sproto file")
		local data = f:read "a"
		output = output .. "\n" .. data
	end
	local file = io.open(spbPrefix.. outfile, "w+b")
	file:write(parser.parse(output))
	file:close()
end


local c2sfiles = {
  "package.sproto",
  "role.sproto",
  "foobar.sproto",
  "rpc.sproto",
}
GenerateBinary(c2sfiles, "c2s.spb")