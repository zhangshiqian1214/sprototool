local parser = require "sprotoparser"
local core = require "sproto.core"
local sproto = require "sproto"

local loader = {}

function loader.register(filename, index)
	local f = assert(io.open(filename), "Can't open sproto file")
	local data = f:read "a"
	f:close()
	local sp = core.newproto(parser.parse(data))
	core.saveproto(sp, index)
end

function loader.save(bin, index)
	local sp = core.newproto(bin)
	core.saveproto(sp, index)
end

function loader.save_from_file(filename, index)
	local f = assert(io.open(filename, "rb"), "Can't open sproto file")
	local data = f:read "*all"
	f:close()
	loader.save(data, index)
end

function loader.load_from_spb(filename)
	local f = assert(io.open(filename, "rb"), "Can't open spb file")
	local data = f:read "a"
	f:close()
	loader.save(data, 1)
end

function loader.load(index)
	local sp = core.loadproto(index)
	--  no __gc in metatable
	return sproto.sharenew(sp)
end

return loader

