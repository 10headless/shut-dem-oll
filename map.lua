require "materials/materials"

map = {}
maps = {}
currentMap = "start"
path = {}
pathDis = 0
mapWidth = 0

function map.loadMaps()
	files = love.filesystem.getDirectoryItems("maps/" )
	love.filesystem.load("materials/materials.lua") ()
	for i=1, #files, 1 do
		love.filesystem.load("maps/"..files[i]) ()
		table.insert(maps, {map = m, title = title, filename = filename, height = height, width = width})
	end
end

function map.draw()
	for i, v in ipairs(maps) do
		if v.title == currentMap then
			for x,b in ipairs(v.map) do
				for y, n in ipairs(b) do
					for l, m in ipairs(materials) do
						if n == m.id then
							love.graphics.setColor(m.color[1],m.color[2],m.color[3])
						end
					end
					tmp = v.height-y
					love.graphics.rectangle("fill", 50*(x-1)+15, 50*(tmp)+10, 50,50)

				end
			end
			mapWidth = v.width
		end
	end
end