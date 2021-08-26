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

local header = "SecureShellCrack"
header = header..string.rep(" ", #ip+4-#header)

print(BGorange..header..BGdefault..clac)
print(BGorange.."IP: "..ip..BGdefault..clac)
print("SSH Crack in operation")

local numTable = {}
for y=1, 14 do
	numTable[y] = {}
	for x=1, 8 do
		numTable[y][x] = math.random(1, 255)
	end
end

local allZero = false

while not allZero do
	local randY = math.random(1,#numTable)
	local randX = math.random(1,#numTable[randY])
	while numTable[randY][randX] == 0 do -- don't change an already zero square
		randY = math.random(1,#numTable)
		randX = math.random(1,#numTable[randY])
	end
	numTable[randY][randX] = math.random(0, 255)
	
	
	-- check for all zeroes
	allZero = true
	for y=1, #numTable do
		for x=1, #numTable[y] do
			if numTable[y][x] ~= 0 then
				allZero = false
				break
			end
		end
	end

	for y=1, #numTable do
		local line = ""
		for x=1, #numTable[y] do
			local s = tostring(numTable[y][x])
			if #s == 2 then s = (" "..s)
			elseif #s == 1 then s = (" "..s.." ")
			end
			
			line = line..(numTable[y][x] == 0 and BGgreen or BGred)..s..BGdefault
			if x < #numTable[y] then
				line = line..BGblack.." "..BGdefault
			end
		end
		print(line..BGdefault..clac)
	end
	
	if not allZero then
		io.write(string.rep(string.char(0x1B).."[A", #numTable))
	end
end

print("Crack Successful")
