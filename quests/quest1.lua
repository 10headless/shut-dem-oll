id = "greeny"

place = {x=1200, y = 510, w=35, h = 50, map = "start"}

condit = {"likeme"}

dialogs = {
	{
		name = "hi1",
		start = true,
		condition = nil,
		nexT = {
			{id = 1, name = "bye"}, {id=2, name = "okay"}
		},
		setCondition = nil,
		text = "Hi stranger! I like you so much that I will tell you a really long story. I don't know why. I just really wanna do that, you seem really cool. Maybe it's because you're playing my game. It's so boring in here. There is nothing to do, you haven't even got inventory yet, but you're still playing and i admire you for that. I really really do. You're the most awesome man i've ever met, even though i haven't really met you. But whatever. You're still reading this",
		answers = {
			{id = 1, text = "Hi!"},
			{id = 2, text = "Get the hell outta here!"}
		}
	},
	{
		name = "bye",
		start = false,
		condition = nil,
		nexT = {
			{id = 1, name = "EXITEND"}
		},
		setCondition = {
			{c = "likeme:true"}
		},
		text = "Bye man, I have to go",
		answers = {
			{id = 1, text = "Bye!"}
		}
	},
	{
		name = "okay",
		start = false,
		condition = nil,
		nexT = {
			{id = 1, name = "EXITEND"}
		},
		setCondition = {
			{c = "likeme:false"}
		},
		text = "Okay, man!",
		answers = {
			{id = 1, text = "Run faster!"}
		}
	},
	{
		name = "dontlikeme",
		start = true,
		condition = {
			{c = "likeme:false"}
		},
		nexT = {
			{id = 1, name = "EXITEND"},
			{id = 2, name = "sorry"}
		},
		setCondition = nil,
		text = "Go away!",
		answers = {
			{id = 1, text = "Run Forest run!"},
			{id = 2, text = "I'm sorry man!"}
		}
	},
	{
		name = "likeme",
		start = true,
		condition = {
			{c = "likeme:true"}
		},
		nexT = {
			{id = 1, name = "EXITEND"}
		},
		setCondition = nil,
		text = "Hi!",
		answers = {
			{id = 1, text = "Hey!"}
		}
	},
	{
		name = "sorry",
		start = false,
		condition = nil,
		nexT = {
			{id = 1, name = "EXITEND"}
		},
		setCondition = {
			{c = "likeme:n"}
		},
		text = "It's okay :)",
		answers = {
			{id = 1, text = "I'm really sorry..."}
		}
	}
}