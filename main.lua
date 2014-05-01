require "player"

keys = {up = "w", down = "s", left = "a", right = "d", shoot = "lctrl"}
bullets = {}
sBullet = {w = 6, h = 20, speed = 400}     --Standard bullet (to make stuff easy to tweak and change)

function love.load()
	player.load(200,200,60,60)
end

function love.update(dt)
	player.update(dt)
end

function love.draw()
	player.draw()
end


function love.keypressed(key)
	if key == "lctrl" then
		player.shoot()
	end
end