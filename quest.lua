require "camera"

quest = {}
q = {}
questTrue = false
selectedA = 1

function quest.run(func)
	if func == "1" then
		q.text = "Hi stranger!"
		q.answers = {
			{text = "Hi!", c = "1"},
			{text = "Get the hell out of here!", c = "2"}
		}
	end
	questTrue = true
end

function quest.draw()
	if q.text ~= nil then
		love.graphics.setColor(40,40,40)
		love.graphics.rectangle("fill", 0+camera.x, 720-15-5*#q.answers-fontBig:getHeight()*(#q.answers+1), 1280, 15+5*#q.answers+fontBig:getHeight()*(#q.answers+1))
		love.graphics.setColor(230,230,230)
		love.graphics.print(q.text, 5+camera.x, 720-15-5*#q.answers-fontBig:getHeight()*(#q.answers+1)+1*fontBig:getHeight())
		love.graphics.print(q.text, 5+camera.x, 720-15-5*#q.answers-fontBig:getHeight()*(#q.answers+1)+2*fontBig:getHeight())
		love.graphics.print(q.text, 5+camera.x, 720-15-5*#q.answers-fontBig:getHeight()*(#q.answers+1)+3*fontBig:getHeight())
	else
		questTrue = false
	end
end