-- Ship Control Protocol v2.0
-- Developer: MCNaOtlichno_YT
-- No AI-generated code used


config = require("scp_config")
functions = require("scp_functions")
positions = {[1] = {7, 9},
              [2] = {10, 10},
			  [3] = {12, 12},
			  [4] = {10, 14},
			  [5] = {7, 15},
			  [6] = {4, 14},
			  [7] = {2, 12},
			  [8] = {4, 10}}
sides = "WNES"

heading = getHeading() * 180 / math.pi
print("Ship Control Protocol v2.1")
print("--------------------------------------------------")
print("Testing is required for correct flights")
print("Look forward and check your orientation compared")
print("to directions of north, south, etc")
print("Continue (hit Enter) if this image matches your")
print("orientation. If not then change heading_offset")
print("in the config file (bottom line)")
print("      x      ")
print("   x     x   ")
print("      ^      ")
print(" x   YOU   x ")
print("             ")
print("   x     x   ")
print("      x      ")
if heading >= 0 and heading <= 22.5 then
	start = 1
elseif heading > 22.5 and heading < 67.5 then
	start = 8
elseif heading >= 67.5 and heading <= 112.5 then
	start = 7
elseif heading > 112.5 and heading < 157.5 then
	start = 6
elseif heading > 157.5 then
	start = 5
elseif heading <= 0 and heading >= -22.5 then
	start = 1
elseif heading < -22.5 and heading > -67.5 then
	start = 2
elseif heading <= -67.5 and heading >= -112.5 then
	start = 3
elseif heading < -112.5 and heading > -157.5 then
	start = 4
elseif heading <= -157.5 then
	start = 5
end
for i = 0, 3 do
	n = start + i * 2
	if n > 8 then n = n - 8 end
	term.setCursorPos(positions[n][1], positions[n][2])
	term.write(string.sub(sides, n + 1, n + 1))
end
io.read()
while true do
	term.clear()
	term.setCursorPos(1, 1)
	print("Ship Control Protocol v2.1')
	print("--------------------------------------------------")
	print("Enter destination X:")
	x = tonumber(io.read())
	print("Enter destination Z:")
	z = tonumber(io.read())
	print('Flying to destination')
	flyToCoords(x, z)
	print('Flight complete. Hit Enter for new flight')
	io.read()
end
