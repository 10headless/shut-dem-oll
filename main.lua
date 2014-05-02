love.math.setRandomSeed(os.time())
require "player"
require "enemy"
require "menu"
require "particles"
require "camera"
require "map"

gamestate = "menu"

keys = {jump = " ", down = "s", left = "a", right = "d", shoot = "lctrl", u2 = "up", d2 = "down", r2 = "right", l2 = "left"}
bullets = {}
sBullet = {w = 8, h = 8, speed = 400, power = 25}     --Standard bullet (to make stuff easy to tweak and change)
fontBig = love.graphics.newFont(30)
blood = love.graphics.newImage("assets/blood2.png")

function love.load()
	love.graphics.setBackgroundColor(240,240,240)
	player.load(1000,500,50,50, 50)
	enemy.load(1200, 500, 50, 50, 50, 700, 2)
	menu.createButton(200, 200, 40, 20, true, true, "PLAY", "play", "menu")
	menu.createButton(200, 270, 40, 20, true, true, "EXIT", "exit", "menu")
	map.loadMaps()
end

function love.update(dt)
	if gamestate == "game" then
		player.update(dt)
		enemy.update(dt)
		update_effect(dt)

		--Camera movement
		if player.x+player.w/2 > 1280/2 and player.x + player.w/2 < mapWidth*50+50+30 - 1280/2 then
			camera.x = player.x + player.w/2 - 1280/2
		end
	end
	if gamestate == "menu" then
		menu.update(dt, "menu")
	end
end

function love.draw()
	camera:set()
	if gamestate == "game" then
		map.draw()
		player.draw()
		enemy.draw()
		draw_effect()
	end
	if gamestate == "menu" then
		menu.draw("menu")
	end
	camera:unset()
end


function love.keypressed(key)
	if gamestate == "game" then
		if key == "lctrl" then
			player.shoot()
		end
		if key == keys.jump then
			player.jump()
		end
	end
end



function checkCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)

  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function bounds(a1, b1, a2, b2) 
	if a1 < a2 + b2 and a1 + b1 > a2 then
		return true
	end
	return false
end