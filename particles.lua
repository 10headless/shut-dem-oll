effects = {}

local p_min = 50
local p_max = 50
local p_spread = 360
local p_velocity_min = 90
local p_velocity_max = 120
local p_gravity = 375
local p_floor = 145 - (16 / 8)
local p_lifetime = 4
local p_bounce = 0
local p_limit =25
function place_effect(x,y,r_bias,image)
	local p_count = math.random(p_min,p_max)
	local effect_buffer = {image}
	for i = 1, p_count do
		vel = math.random(p_velocity_min, p_velocity_max)
		local r = math.rad(math.random(-p_spread/2,p_spread/2)) - math.pi/2 + r_bias
		local vx = math.cos(r) * vel
		local vy = math.sin(r) * vel 
		table.insert(effect_buffer, {x,y,vx,vy,0})
	end
	table.insert(effects, effect_buffer)
end

function update_effect(dt)
	for i,v in ipairs(effects) do
	if #effects > p_limit then
		
			table.remove(effects, i)
		
	end
	end
	for i,v in ipairs(effects) do
		if #v < 2 then 
			table.remove(effects, i)
		end

		for r,k in ipairs(v) do
			if r > 1 then
				k[5] = k[5] + dt
				if math.abs(k[3]) > 1 then
					k[1] = k[1] + k[3] * dt
					k[2] = k[2] + k[4] * dt
					k[4] = k[4] + p_gravity * dt
					
				end
				if k[5] > p_lifetime then
					table.remove(v,r)
				end
			end
		end
	end
end

function draw_effect()
	for i,v in ipairs(effects) do
		for r,k in ipairs(v) do
			if r > 1 then
				love.graphics.setColor(255,255,255)
				love.graphics.draw(v[1],k[1],k[2], 0, 0.2, 0.2)
			end
		end
	end

end