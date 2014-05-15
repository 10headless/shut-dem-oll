str = {}

function str.questLineManipulation(a, b)
	cou = 0
	e = {}
	t, cou = str.findAll(a, " ")
	for i, v in ipairs(b) do
		w, countTmp = str.findAll(v, " ")
		cou = cou + countTmp
		e[i] = w
	end
	return t, e, cou
end



function str.findAll(s, l)
	count = 0
	string = {}
	spacePlaces = {}
	for i = 1, #s, 1 do
		string[i] = s:sub(i,i)
	end
	firstTime = true
	lastBreak = 1
	for i, v in ipairs(string) do
		if v == " " then
			table.insert(spacePlaces, i)
			length = 0

			if firstTime then
				for j = 1, i, 1 do
					length =  length + fontMid:getWidth(string[j])
				end
				firstTime = false
			else
				for j = lastBreak, i, 1 do
					length =  length + fontMid:getWidth(string[j])
				end
			end
			if length > 1280 then
				string[spacePlaces[#spacePlaces-1]] = "\n"
				lastBreak = spacePlaces[#spacePlaces-1] + 1
				count = count + 1
			end
		end
	end
	ks = ""
	for i, v in ipairs(string) do
		ks = ks .. v
	end
	return ks, count+1
end