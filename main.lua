love.math.setRandomSeed(os.time())
require "player"
require "enemy"
require "menu"

gamestate = "menu"

keys = {up = "w", down = "s", left = "a", right = "d", shoot = "lctrl", u2 = "up", d2 = "down", r2 = "right", l2 = "left"}
bullets = {}
sBullet = {w = 8, h = 8, speed = 400, power = 25}     --Standard bullet (to make stuff easy to tweak and change)
fontBig = love.graphics.newFont(30)

function love.load()
	love.graphics.setBackgroundColor(240,240,240)
	player.load(200,200,60,60, 50)
	enemy.load(1200, 500, 50, 50, 50, 700, 2)
	menu.createButton(200, 200, 40, 20, true, true, "PLAY", "play", "menu")
end

function love.update(dt)
	if gamestate == "game" then
		player.update(dt)
		enemy.update(dt)
	end
	if gamestate == "menu" then
		menu.update(dt, "menu")
	end
end

function love.draw()
	if gamestate == "game" then
		player.draw()
		enemy.draw()
	end
	if gamestate == "menu" then
		menu.draw("menu")
	end
end


function love.keypressed(key)
	if gamestate == "game" then
		if key == "lctrl" then
			player.shoot()
		end
	end
end



function checkCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)

  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end