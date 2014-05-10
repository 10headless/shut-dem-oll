require "camera"
require "str"

quest = {}
q = {}
q.text = nil
q.answers = {}
questTrue = false
selectedA = 1
txt = ""
ans = {}
count = 0
qtmp = {}

function quest.run(func, screen)
	selectedA = 1
	if func == "1" then
		if screen == "1" then
			q.text = "Hi stranger! I like you so much that I will tell you a really long story. I don't know why. I just really wanna do that, you seem really cool. Maybe it's because you're playing my game. It's so boring in here. There is nothing to do, you haven't even got inventory yet, but you're still playing and i admire you for that. I really really do. You're the most awesome man i've ever met, even though i haven't really met you. But whatever. You're still reading this"
			q.answers = {
				{text = "Hi!", c = "1_1_1"},
				{text = "Get the hell out of here!", c = "1_1_2"},
				{text = "I like you!", c = "1_1_3"}
			}
		end
		if screen == "2" then
			q.text = "Okay"
			q.answers = {
				{text = "Bye!", c = "1_1_1"},
			}
		end
	end
	questTrue = true
	qtmp = q
	txt, ans, count = str.questLineManipulation(qtmp.text, qtmp.answers)
end

function quest.draw()
	if q.text ~= nil then
		love.graphics.setColor(40,40,40)
		love.graphics.setFont(fontMid)
		love.graphics.rectangle("fill", camera.x, 720 -(20 + count * (fontMid:getHeight()+10)), 1280, 20 + count * (fontMid:getHeight() + 10))
		love.graphics.setColor(230,230,230)
		love.graphics.print(txt, 8+camera.x, 720 - (10 + count * (fontMid:getHeight()+10)))
		for i = 1, #ans, 1 do
			width, he = fontMid:getWrap(txt, 1280)
			if i > 1 then
				for j = 1, i-1, 1 do
					width, htmp = fontMid:getWrap(ans[j], 1280)
					if htmp == nil then
						he = he +1 
					else
						he = he + htmp
					end
				end
			end
			if selectedA == i then
				love.graphics.rectangle("fill", 6+camera.x, 720 -2- (10 + count * (fontMid:getHeight()+10))+(he)*(fontMid:getHeight()+10), 
					fontMid:getWidth(ans[i])+4, fontMid:getHeight()+4)
				love.graphics.setColor(40,40,40)
			else
				love.graphics.setColor(230,230,230)
			end
			love.graphics.print(ans[i], 8+camera.x, 720 - (10 + count * (fontMid:getHeight()+10))+(he)*(fontMid:getHeight()+10))
		end
	else
		questTrue = false
	end
end



function quest.enter(thing)
	if thing == "1_1_2" then
		quest.run("1", "2")
		return
	end
	if thing == "1_1_1" then
		q.text = nil
		return
	end
end