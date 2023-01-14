extends Node2D

var line_length = 34
var default_speed = 0.07

# command language:
# everything between %% is a command
# #w# (toggle wiggle)
# %wr% (toggle wiggle, rainbow)

# Called when the node enters the scene tree for the first time.
func _ready():
	say("charming superflous valorous %w%chimichangas%w% rustle gloriously in all weather conditions, regardless")

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
	var wiggle_flag = false
	var letters = letter_elements()
	
	for character in string:
		if(counter > letters.size() - 1):
			print ("Warning! Phrase exceeds maximum size: ", string)
			pass
		elif command_mode:
			if String(character) == "w":
				wiggle_flag = !wiggle_flag
			if String(character) == "%":
				command_mode = false
		elif String(character) == "%":
			command_mode = true
		else:
			var child = letters[counter]
			child.setChar(character)
			if wiggle_flag:
				child.wiggle()
			if character != " ":
				await get_tree().create_timer(default_speed).timeout
			counter = counter + 1

func say(string):
	clear()
	var wrapped_string = _wordwrap(string)
	_display(wrapped_string)

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
