player = {}

function player.load(x, y, w, h)
	player.x = x
	player.y = y
	player.w = w
	player.h = h
	player.speed = 300
	player.facing = "u"
end

function player.update(dt)

	if love.keyboard.isDown(keys.down) then
		player.y = player.y + player.speed*dt
		player.facing = "d"
	end
	if love.keyboard.isDown(keys.up) then
		player.y = player.y - player.speed*dt
		player.facing = "u"
	end
	if love.keyboard.isDown(keys.right) then
		player.x = player.x + player.speed*dt
		player.facing = "r"
	end
	if love.keyboard.isDown(keys.left) then
		player.x = player.x - player.speed*dt
		player.facing = "l"
	end

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

function player.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
	for i, v in ipairs(bullets) do
		if v.facing == "d" or v.facing == "u" then
			love.graphics.rectangle("fill", v.x, v.y, sBullet.w, sBullet.h)
		end
		if v.facing == "r" or v.facing == "l" then
			love.graphics.rectangle("fill", v.x, v.y, sBullet.h, sBullet.w)
		end
	end
end

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