extends Node2D

var line_length = 34
var default_speed = 0.07
var pause_time = 1.0

# command language:
# everything between %% is a command
# #w# (toggle wiggle)
# %wr% (toggle wiggle, rainbow)

# Called when the node enters the scene tree for the first time.
func _ready():
	await say("%r%ROYAL RAINBOW beeeoooooowwwww")
	#await say("then the keyboard was like %k%clacka clacka clacka clacka %p% ker-ching!%k% %p%")
	#await say("and then he said %W%WHOOOAAAAH HAH%W%!!! %p%")
	#await say("normal %f%fast fast fast%f% %s%slow slow slow%s% and then %p%stop")
	#await say("the radio this morning promised %w%ten tonnes of cheese%w% to the highest bidder")
	#await say("charming superflous valorous %w%chimichangas%w% rustle gloriously in all weather conditions, regardless")
	

func letter_elements():
	var arr = []
	arr.append_array($letters/top.get_children())
	arr.append_array($letters/middle.get_children())
	arr.append_array($letters/bottom.get_children())
	return arr

func _adjusted_length(string):
	# counts length, ignoring any control characters
	var newstring = ""
	var command_mode = false
	for character in string:
		if command_mode:
			if String(character) == "%":
				command_mode = false
		elif String(character) == "%":
			command_mode = true
		else:
			newstring = newstring + character
	return newstring.length()

func _wordwrap(string):
	# slice everything into three lines, wrapping words (this is a very rudimentary word-wrap)
	var rows = PackedStringArray(["", "", "", ""]) #top, middle, bottom, o'erflow
	var current_row = 0
	
	var words = string.split(" ")
	var current_word = words[0]
	for word in words:
		var current_line = rows[current_row]
		var prospective_line_length = _adjusted_length(current_line) + _adjusted_length(word)
		
		if prospective_line_length < line_length:
			rows[current_row] = rows[current_row] + word + " "
		if prospective_line_length == line_length:
			rows[current_row] = rows[current_row] + word
		if prospective_line_length > line_length:
			while _adjusted_length(rows[current_row]) < line_length:
				rows[current_row] = rows[current_row] + " "
			current_row = current_row + 1
			rows[current_row] = rows[current_row] + word + " "
	
	var word_wrapped_string = "".join(rows)
	return word_wrapped_string

func _display(string):
	var counter = 0
	var command_mode = false
	var fast_flag = false
	var slow_flag = false
	var wiggle_flag = false
	var wobble_flag = false
	var kachunk_flag = false
	var rainbow_flag = false
	var letters = letter_elements()
	
	for character in string:
		if(counter > letters.size() - 1):
			print ("Warning! Phrase exceeds maximum size: ", string)
			pass
		elif command_mode:
			if String(character) == "w":
				wiggle_flag = !wiggle_flag
			if String(character) == "W":
				wobble_flag = !wobble_flag
			if String(character) == "k":
				kachunk_flag = !kachunk_flag
			if String(character) == "r":
				rainbow_flag = !rainbow_flag
			if String(character) == "f":
				fast_flag = !fast_flag
			if String(character) == "s":
				slow_flag = !slow_flag
			if String(character) == "p":
				await get_tree().create_timer(pause_time).timeout
			if String(character) == "%":
				command_mode = false
		elif String(character) == "%":
			command_mode = true
		else:
			var child = letters[counter]
			child.setChar(character)
			if wiggle_flag:
				child.wiggle()
			if wobble_flag:
				child.wobble()
			if kachunk_flag:
				child.kachunk()
			if rainbow_flag:
				child.rainbow()
			if character != " ":
				var speed = default_speed
				if fast_flag:
					speed = speed * 0.3
				if slow_flag:
					speed = speed * 2	
				await get_tree().create_timer(speed).timeout
			counter = counter + 1

func say(string):
	clear()
	var wrapped_string = _wordwrap(string)
	await _display(wrapped_string)

func clear():
	for child in letter_elements():
		child.setChar(" ")

func aaaa():
	for child in letter_elements():
		child.setChar("a")

func wobble():
	for child in letter_elements():
		child.wobble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
