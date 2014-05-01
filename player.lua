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
end

--Basic physics
function player.physics(dt)
	player.x = player.x + player.xvel * dt
	player.y = player.y + player.yvel * dt
	player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
	player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1))
end

--Player movement
function player.control(dt)
	if love.keyboard.isDown(keys.down) and player.yvel < player.speed then
		player.yvel = player.yvel + player.speed*dt
		player.facing = "d"
	end
	if love.keyboard.isDown(keys.up) and player.yvel > -player.speed  then
		player.yvel = player.yvel - player.speed*dt
		player.facing = "u"
	end
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
	if player.facing == "u" then
		table.insert(bullets, {x = (player.x + (player.w - sBullet.w) / 2), y = player.y - sBullet.h, facing = "u"})
	end
	if player.facing == "d" then
		table.insert(bullets, {x = (player.x + (player.w - sBullet.w) / 2), y = player.y + player.h, facing = "d"})
	end
	if player.facing == "r" then
		table.insert(bullets, {x = player.x + player.w, y = player.y + (player.h-sBullet.w)/2, facing = "r"})
	end
	if player.facing == "l" then
		table.insert(bullets, {x = player.x - sBullet.h, y = player.y + (player.h-sBullet.w)/2, facing = "l"})
	end
end

--Bullet movement
function bulletUpdate(dt)
	for i, v in ipairs(bullets) do
		if v.facing == "u" then
			v.y = v.y - sBullet.speed*dt
		end
		if v.facing == "d" then
			v.y = v.y + sBullet.speed*dt
		end
		if v.facing == "r" then
			v.x = v.x + sBullet.speed*dt
		end
		if v.facing == "l" then
			v.x = v.x - sBullet.speed*dt
		end
	end
end

--*****DRAWING DRAWING DRAWING DRAWING*****

--Bullet drawing
function bulletDraw()
	for i, v in ipairs(bullets) do
		if v.facing == "d" or v.facing == "u" then
			love.graphics.rectangle("fill", v.x, v.y, sBullet.w, sBullet.h)
		end
		if v.facing == "r" or v.facing == "l" then
			love.graphics.rectangle("fill", v.x, v.y, sBullet.h, sBullet.w)
		end
	end
end





function player.update(dt)
	player.control(dt)	
	player.physics(dt)
	bulletUpdate(dt)
end

function player.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
	bulletDraw()
end