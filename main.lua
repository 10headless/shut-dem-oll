require "player"
require "enemy"

keys = {up = "w", down = "s", left = "a", right = "d", shoot = "lctrl"}
bullets = {}
sBullet = {w = 6, h = 20, speed = 400}     --Standard bullet (to make stuff easy to tweak and change)

function love.load()
	player.load(200,200,60,60, 50)
	enemy.load(1200, 500, 50, 50, 100, 700, 2)
end

function love.update(dt)
	player.update(dt)
	enemy.update(dt)
end

function love.draw()
	player.draw()
	enemy.draw()
end


function love.keypressed(key)
	if key == "lctrl" then
		player.shoot()
	end
end