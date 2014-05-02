menu = {}
buttons = {}

function menu.createButton(x, y, w, h, autoSize, setOffset, text, func, cat)
	if autoSize then
		if setOffset then
			table.insert(buttons, {x = x, y = y, w = fontBig:getWidth(text)+w, h = fontBig:getHeight()+h, text = text, func = func, cat = cat})
		else
			table.insert(buttons, {x = x, y = y, w = fontBig:getWidth(text)+40, h = fontBig:getHeight()+20, text = text, func = func, cat = cat})
		end
	else
		table.insert(buttons, {x = x, y = y, w = w, h = h, text = text, func = func, cat = cat})
	end
end

function menu.update(dt, category)
	for i, v in ipairs(buttons) do
		if v.cat == category then
			mX = love.mouse.getX()
			mY = love.mouse.getY()
			if love.mouse.isDown("l") then
				if checkCollision(v.x, v.y, v.w, v.h, mX, mY, 1, 1) then
					menu.buttonPressed(v.func)
				end
			end
		end
	end
end

function menu.draw(category)
	for i, v in ipairs(buttons) do
		if v.cat == category then
			mX = love.mouse.getX()
			mY = love.mouse.getY()
			if checkCollision(v.x, v.y, v.w, v.h, mX, mY, 1, 1) then
				love.graphics.setColor(160, 160, 160)
			else
				love.graphics.setColor(90, 90, 90)
			end
			love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
			love.graphics.setColor(255,255,255)
			love.graphics.setFont(fontBig)
			love.graphics.print(v.text, v.x+v.w/2 - fontBig:getWidth(v.text)/2, v.y+v.h/2-fontBig:getHeight()/2)
		end
	end
end




function menu.buttonPressed(func) 
	if func == "play" then
		gamestate = "game"
	end
	if func == "exit" then
		love.event.quit()
	end
end