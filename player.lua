require "map"

player = {}

function player.load(x, y, w, h, power)
	player.x = x
	player.y = y
	player.w = w
	player.h = h
	player.speed = 1600
	player.facing = "u"
	player.friction = 5
	player.xvel = 0
	player.yvel = 0
	player.power = power
	player.health = 100
	player.maxHealth = 100
end

--Basic physics
function player.physics(dt)
	player.x = player.x + player.xvel * dt
	player.y = player.y + player.yvel * dt
	player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
	player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1))
end

--Player movement, shoot direction control and map collisions
function player.control(dt)
	if love.keyboard.isDown(keys.right) and player.xvel < player.speed then
		player.xvel = player.xvel + player.speed*dt
		player.facing = "r"
	end
	if love.keyboard.isDown(keys.left) and player.xvel > -player.speed then
		player.xvel = player.xvel - player.speed*dt
		player.facing = "l"
	end


end

--Shoot handling
function player.shoot()
	if player.facing == "r" then
		table.insert(bullets, {x = player.x + player.w, y = player.y + (player.h-sBullet.w)/2, xvel = sBullet.speed, yvel = 0})
	end
	if player.facing == "l" then
		table.insert(bullets, {x = player.x - sBullet.h, y = player.y + (player.h-sBullet.w)/2, xvel = -sBullet.speed, yvel = 0})
	end
end

--Bullet movement
function bulletUpdate(dt)
	for i, v in ipairs(bullets) do
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel *dt
	end
end

--*****DRAWING DRAWING DRAWING DRAWING*****

--Bullet drawing
function bulletDraw()
	for i, v in ipairs(bullets) do
		love.graphics.setColor(0,250,0)
		love.graphics.rectangle("fill", v.x, v.y, sBullet.w, sBullet.h)
	end
end

--In-game HUB drawing
function hubDraw()
	love.graphics.setColor(90,90,90)
	love.graphics.rectangle("fill", 1080+camera.x, 710, 200, 10)
	love.graphics.setColor(0,255,0)
	love.graphics.rectangle("fill", 1080+camera.x, 710, 200,10)
	love.graphics.setColor(90,90,90)
	love.graphics.rectangle("fill", 1080+camera.x, 700, 200, 10)
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", 1080+camera.x, 700, 200*(player.health/player.maxHealth),10)
end



function player.update(dt)
	player.control(dt)	
	player.physics(dt)
	bulletUpdate(dt)
end

function player.draw()
	love.graphics.setColor(60,60,60)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
	bulletDraw()
	hubDraw()
end
