local lfs = require "lfs"
local parser = require "sprotoparser"
local base64 = require "base64"

local function find_name(path, patten, intosubdir, result)
	result = result or {}
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = string.gsub(path.."/"..file, "//", "/")
			local attr = lfs.attributes(f)
			assert (type(attr) == "table")
			if attr.mode == "directory" and intosubdir then
				find_name(f, patten, intosubdir, result)
			else
				if string.find(f, patten) ~= nil then
					table.insert(result, f)
				end
			end
		end
	end
	return result
end

local function dump(dump_path, content, isb64)
	local dump_file = "protocol.spt"
	local err = "can't open "..dump_path..dump_file
	local f = assert(io.open(dump_path..dump_file, "w+b"), err)
	if isb64 then
		f:write(base64.encode(content))
	else
		f:write(content)
	end
  	f:close()
end

return function(src_path, des_path)
	if string.sub(src_path, -1) ~= "/" then 
		src_path = src_path .. "/"
	end
	if string.sub(des_path, -1) ~= "/" then
		des_path = des_path .. "/"
	end
	local sproto_files = {}
	local files = find_name(src_path, "%.sproto", true)
	for _, file in pairs(files) do
		sproto_files[file] = true
	end
	if not next(sproto_files) then
		return print("sproto file not exist")
	end

	local content = ""
	for path, _ in pairs(sproto_files) do
		local f = assert(io.open(path), "Can't open "..path)
		local data = f:read "a"
		content = content .. "\n" .. data
		f:close()
	end

	return dump(des_path, parser.parse(content), false)
end