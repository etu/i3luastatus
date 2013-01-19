#!/usr/bin/env lua

-- Load the JSON library
jsonpath = arg[0]:gsub('wrapper.lua', 'JSON.lua')
JSON     = loadfile(jsonpath)()

-- respond with i3 protocol format, no "," the first time
first = true

function i3respond(list)
	if first then
		print(JSON:encode(list))
		first = false
	else
		print(',' .. JSON:encode(list))
	end
end

-- Print some i3 protocoll stuff
print('{"version":1}')
print('[')

-- While read data from stdin
while true do
	local line = io.read()
	
	-- Construct the response
	response = {
		{
			name      = "load",
			full_text = io.lines('/proc/loadavg')()
		}, {
			name      = "time",
			full_text = os.date('%Y-%m-%d %H:%M:%S')
		}
	}
	
	-- Respond!
	i3respond(response)
end

