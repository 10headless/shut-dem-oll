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
end

--Basic physics
function player.physics(dt)
	player.x = player.x + player.xvel * dt
	player.y = player.y + player.yvel * dt
	player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
	player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1))
end

--Player movement and shoot direction control
function player.control(dt)
	if love.keyboard.isDown(keys.down) and player.yvel < player.speed then
		player.yvel = player.yvel + player.speed*dt
	end
	if love.keyboard.isDown(keys.up) and player.yvel > -player.speed  then
		player.yvel = player.yvel - player.speed*dt
	end
	if love.keyboard.isDown(keys.right) and player.xvel < player.speed then
		player.xvel = player.xvel + player.speed*dt
	end
	if love.keyboard.isDown(keys.left) and player.xvel > -player.speed then
		player.xvel = player.xvel - player.speed*dt
	end

	if love.keyboard.isDown(keys.u2) and love.keyboard.isDown(keys.l2)~= true and love.keyboard.isDown(keys.r2)~=true then
		player.facing = "u"
	end
	if love.keyboard.isDown(keys.d2) and love.keyboard.isDown(keys.l2)~= true and love.keyboard.isDown(keys.r2)~=true then
		player.facing = "d"
	end
	if love.keyboard.isDown(keys.r2) and love.keyboard.isDown(keys.u2)~= true and love.keyboard.isDown(keys.d2)~=true then
		player.facing = "r"
	end
	if love.keyboard.isDown(keys.l2) and love.keyboard.isDown(keys.u2)~= true and love.keyboard.isDown(keys.d2)~=true then
		player.facing = "l"
	end
	if love.keyboard.isDown(keys.u2) and love.keyboard.isDown(keys.l2) then
		player.facing = "ul"
	end
	if love.keyboard.isDown(keys.u2) and love.keyboard.isDown(keys.r2) then
		player.facing = "ur"
	end
	if love.keyboard.isDown(keys.d2) and love.keyboard.isDown(keys.l2) then
		player.facing = "dl"
	end
	if love.keyboard.isDown(keys.d2) and love.keyboard.isDown(keys.r2) then
		player.facing = "dr"
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
	if player.facing == "ul" then
		table.insert(bullets, {x = player.x - sBullet.h/math.sqrt(2), y = player.y - sBullet.h/math.sqrt(2), facing = "ul"})
	end
	if player.facing == "ur" then
		table.insert(bullets, {x = player.x + player.w + sBullet.h/math.sqrt(2), y = player.y - sBullet.h/math.sqrt(2), facing = "ur"})
	end
	if player.facing == "dl" then
		table.insert(bullets, {x = player.x - sBullet.h/math.sqrt(2), y = player.y + player.h + sBullet.h/math.sqrt(2), facing = "dl"})
	end
	if player.facing == "dr" then
		table.insert(bullets, {x = player.x + player.w + sBullet.h/math.sqrt(2), y = player.y + player.h + sBullet.h/math.sqrt(2), facing = "dr"})
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
		if v.facing == "ur" then
			v.x = v.x + (sBullet.speed/math.sqrt(2))*dt
			v.y = v.y - (sBullet.speed/math.sqrt(2))*dt
		end
		if v.facing == "ul" then
			v.x = v.x - (sBullet.speed/math.sqrt(2))*dt
			v.y = v.y - (sBullet.speed/math.sqrt(2))*dt
		end
		if v.facing == "dr" then
			v.x = v.x + (sBullet.speed/math.sqrt(2))*dt
			v.y = v.y + (sBullet.speed/math.sqrt(2))*dt
		end
		if v.facing == "dl" then
			v.x = v.x - (sBullet.speed/math.sqrt(2))*dt
			v.y = v.y + (sBullet.speed/math.sqrt(2))*dt
		end
	end
end

--*****DRAWING DRAWING DRAWING DRAWING*****

--Bullet drawing
function bulletDraw()
	for i, v in ipairs(bullets) do
		love.graphics.rectangle("fill", v.x, v.y, sBullet.w, sBullet.h)
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