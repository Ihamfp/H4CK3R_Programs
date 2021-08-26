#!/usr/bin/lua5.3

local args = {...}

local BGblack = string.char(0x1B).."[40m"
local BGred = string.char(0x1B).."[41m"
local BGgreen = string.char(0x1B).."[42m"
local BGorange = string.char(0x1B).."[43m"
local BGdefault = string.char(0x1B).."[49m"

local clac = string.char(0x1B).."[K" -- clear line after cursor

math.randomseed(os.time())
local ip = args[1] or string.format("%03d.%03d.%03d.%03d", math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))

local header = "FTP Bounce"
header = header..string.rep(" ", #ip+4-#header)

print(BGorange..header..BGdefault..clac)
print(BGorange.."IP: "..ip..BGdefault..clac)

local flowLines = {}
for y=1, 6 do
	flowLines[y] = ""
	for x=1, 20 do
		flowLines[y] = flowLines[y]..tostring(math.random(0,1)).." "
	end
end

local decodeLines = {}
for y=1, 4 do
	decodeLines[y] = string.rep(" ", 40)
end

local allShown = false

while not allShown do
	for i=1, #flowLines do
		print(BGdefault..flowLines[i]..clac)
	end
	local randY = math.random(1, #flowLines)
	flowLines[randY] = flowLines[randY]:sub(2,-1)
	if flowLines[randY]:sub(-1,-1) == " " then
		flowLines[randY] = flowLines[randY]..tostring(math.random(0,1))
	else
		flowLines[randY] = flowLines[randY].." "
	end
	
	print(BGdefault..clac)
	
	print("Working ::"..clac)
	for i=1, #decodeLines do
		print(BGred..decodeLines[i]..BGdefault..clac)
	end
	
	local randY = math.random(1, #decodeLines)
	local randX = math.random(1, #decodeLines[randY])
	while decodeLines[randY]:sub(randX,randX) ~= " " do
		randY = math.random(1, #decodeLines)
		randX = math.random(1, #decodeLines[randY])
	end
	decodeLines[randY] = decodeLines[randY]:sub(1,randX-1)..tostring(math.random(0,1))..decodeLines[randY]:sub(randX+1,-1)
	
	allShown = true
	for i=1, #decodeLines do
		if decodeLines[i]:find(" ") then
			allShown = false
			break
		end
	end
	
	if not allShown then
		io.write(string.rep(string.char(0x1B).."[A", #flowLines+#decodeLines+2))
	end
	
	local a = math.random(1, 10)
	for i=1, 1000000 do -- make it look like you're doing things
		a = a + math.sqrt(a) -- do things
	end
end

print("FTP Bounce Successful")
