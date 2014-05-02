require "player"
require "particles"

enemy = {}
enemies = {}
enemy.timer = 0
enemy.timerLimit = love.math.random(3, 5)

function enemy.load(x, y, w, h, health, speed, friction)
	table.insert(enemies, {x = x, y = y, w = w, h = h, health = health, speed = speed, friction = friction, xvel = 0, yvel = 0})
end

--Basic physics
function enemy.physics(dt)
	for i, v in ipairs(enemies) do
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel * dt
		v.xvel = v.xvel * (1 - math.min(dt*v.friction, 1))
		v.yvel = v.yvel * (1 - math.min(dt*v.friction, 1))
	end
end

--Enemy movement
function enemy.move(dt)
	for i, v in ipairs(enemies) do
		if player.x+player.w/2 > v.x+v.w/2 then
			if player.y+player.h/2 ~= v.y+v.h/2 then
				if v.xvel < v.speed/math.sqrt(2) then
					v.xvel = v.xvel + (v.speed/(math.sqrt(2))) * dt
				end
			else
				if v.xvel < v.speed then
					v.xvel = v.xvel + v.speed*dt
				end
			end
		end
		if player.x+player.w/2 < v.x+v.w/2 then
			if player.y+player.h/2 ~= v.y+v.h/2 then
				if v.xvel > -v.speed/math.sqrt(2) then
					v.xvel = v.xvel - (v.speed/(math.sqrt(2))) * dt
				end
			else
				if v.xvel > -v.speed then
					v.xvel = v.xvel - (v.speed) * dt
				end
			end
		end
		if player.y+player.h/2 > v.y+v.h/2 then
			if player.x+player.w/2 ~= v.x+v.w/2 then
				if v.yvel < v.speed/math.sqrt(2) then
					v.yvel = v.yvel + (v.speed/(math.sqrt(2))) * dt
				end
			else
				if v.xvel > -v.speed then
					v.xvel = v.xvel - (v.speed) * dt
				end
			end
		end
		if player.y+player.h/2 < v.y+v.h/2 then
			if player.x+player.w/2 ~= v.x+v.w/2 then
				if v.yvel > -v.speed/math.sqrt(2) then
					v.yvel = v.yvel - (v.speed/(math.sqrt(2))) * dt
				end
			else
				if v.xvel > -v.speed then
					v.xvel = v.xvel - (v.speed) * dt
				end
			end
		end
	end
end

--Collision handling
function enemy.collisions()
	remEnemy = {}
	remShots = {}
	for i, v in ipairs(bullets) do
		for j, b in ipairs(enemies) do
			if checkCollision(b.x, b.y, b.w, b.h, v.x, v.y, sBullet.w, sBullet.h) then
				table.insert(remShots, i)
				b.health = b.health - sBullet.power
				if b.health <= 0 then
					table.insert(remEnemy, j)
				end
			end
		end
	end
	for j, b in ipairs(enemies) do
		if checkCollision(b.x, b.y, b.w, b.h, player.x, player.y, player.w, player.h) then
			table.insert(remEnemy, j)
			player.health = player.health - b.health
			place_effect(player.x, player.y, 10, blood)
		end
	end

	for i, v in ipairs(remEnemy) do
		table.remove(enemies, v)
	end
	for i, v in ipairs(remShots) do
		table.remove(bullets, v)
	end
end

--Spawning
function enemy.spawn(dt)
	enemy.timer = enemy.timer + dt
	if enemy.timer >= enemy.timerLimit then
		enemy.timer = 0
		enemy.timerLimit = love.math.random(3,5)
		side = math.random(1,4)
		if side == 1 then
			enemy.load(love.math.random(1280), -60, 50, 50, 50, 700, 2)
		elseif side == 2 then
			enemy.load(love.math.random(1280), 1290, 50, 50, 50, 700, 2)
		elseif side == 3 then
			enemy.load(-60, love.math.random(720), 50, 50, 50, 700, 2)
		elseif side == 4 then
			enemy.load(730, love.math.random(720), 50, 50, 50, 700, 2)
		end
	end
end


function enemy.update(dt)
	enemy.physics(dt)
	enemy.move(dt)
	enemy.collisions()
	enemy.spawn(dt)
end

function enemy.draw()
	for i, v in ipairs(enemies) do
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
	end
end