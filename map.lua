require "materials/materials"
require "quest"

map = {}
maps = {}
currentMap = "start"
mapWidth = 0
curMap = {}

function map.loadMaps()
	files = love.filesystem.getDirectoryItems("maps/" )
	love.filesystem.load("materials/materials.lua") ()
	for i=1, #files, 1 do
		love.filesystem.load("maps/"..files[i]) ()
		table.insert(maps, {map = m, title = title, filename = filename, height = height, width = width, qGivers = qGivers})
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
			curMap = v 
			for j, b in ipairs(quests) do
				if b.place.map == currentMap then
					love.graphics.setColor(0,255,0)
					love.graphics.rectangle("fill", b.place.x, b.place.y, b.place.w, b.place.h)
					if checkCollision(b.place.x, b.place.y, b.place.w, b.place.h, player.x, player.y, player.w, player.h) then
						love.graphics.setColor(255,255,255)
						love.graphics.setFont(fontBig)
						love.graphics.print('Press "e" to interact', camera.x+1280/2-fontBig:getWidth('Press "e" to interact')/2, 50)
					end
				end
			end
		end
	end
end

function map.update(dt)
	for j, b in ipairs(quests) do
		if b.place.map == currentMap then
			if checkCollision(b.place.x, b.place.y, b.place.w, b.place.h, player.x, player.y, player.w, player.h) then			
				if love.keyboard.isDown("e") then
					wholeQuest = b
					quest.run(b.dialogs, nil)
				end
			end
		end
	end
end