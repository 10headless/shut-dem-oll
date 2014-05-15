require "camera"
require "str"

quest = {}
que = {}
que.text = nil
que.answers = {}
que.anss = {}
que.fullDialog = {}
questTrue = false
selectedA = 1
txt = ""
ans = {}
count = 0
qtmp = {}
curConversationID = 0
quests = {}
conditions = {}
wholeQuest = {}

function quest.loadQuests()
	files = love.filesystem.getDirectoryItems("quests/" )
	for i=1, #files, 1 do
		love.filesystem.load("quests/"..files[i]) ()
		table.insert(quests, {id = id, place = place, dialogs = dialogs})
		for i, v in ipairs(condit) do
			table.insert(conditions, v)
		end
	end
end

function quest.run(dialog, thing)
	selectedA = 1
	if thing == nil then
		tmpDialog = {}
		for i, v in ipairs(dialog) do
			if v.start == true then
				table.insert(tmpDialog, v)
			end
		end
		tmpDialog2 = {}
		for i, v in ipairs(tmpDialog) do
			if v.condition == nil then
				if tmpDialog2.condition == nil then
					tmpDialog2[1] = v
				end
			else
				accept = true
				for j, b in ipairs(v.condition) do
					x = b.c:find(":")
					y = b.c:sub(1,x-1)
					for k, n in ipairs(conditions) do
						z = n:find(":")
						if z ~= nil then
							t = n:sub(1,z-1)
							if t == y then
								if b.c == n then
									accept = false
									break
								end
							end
						end
					end
				end	

				if accept == false then
					tmpDialog2[1] = v
				end
			end
		end
		que.text = tmpDialog2[1].text
		que.answers = tmpDialog2[1].answers
		que.fullDialog = tmpDialog2[1]
		que.evenFuller = dialog
		que.anss = {}
		for i = 1, #tmpDialog2[1].answers, 1 do
			table.insert(que.anss, tmpDialog2[1].answers[i].text)
		end
	else

		for j, b in ipairs(dialog) do
			if b.name == thing then
				tmpDialog = b
				que.text = tmpDialog.text
				que.answers = tmpDialog.answers
				que.fullDialog = tmpDialog
				que.evenFuller = dialog
				que.anss = {}
				for i = 1, #tmpDialog.answers, 1 do
					table.insert(que.anss, tmpDialog.answers[i].text)
				end
				break
			end
		end
	end
	questTrue = true
	qtmp = que
	txt, ans, count = str.questLineManipulation(qtmp.text, qtmp.anss)
	curConversationID = id
end

function quest.draw()
	if que.text ~= nil then
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

function quest.changeVal()
	-- body
end



function quest.enter(thing)
	if que.fullDialog.setCondition ~= nil then
		for i, v in ipairs(que.fullDialog.setCondition) do
			for j, b in ipairs(conditions) do
				tmp1 = v.c:find(":")
				tmp2 = v.c:sub(1,x-1)
				tmp3 = b:find(":")
				if tmp3 ~= nil then
					tmp4 = b:sub(1,x-1)
				else
					tmp4 = b
				end
				if tmp2 == tmp4 then
					conditions[j] = v.c
					print(v.c)
					break
				end
			end
		end
	end
	if que.fullDialog.nexT[thing].name == "EXITEND" then
		questTrue = false
		que.text = nil
		return
	end
	for i, v in ipairs(wholeQuest.dialogs) do
			if que.fullDialog.nexT[thing].name == v.name then
				quest.run(wholeQuest.dialogs, v.name)
				break
			end
	end
end