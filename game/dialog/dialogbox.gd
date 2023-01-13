extends Node2D

var line_length = 34
var default_speed = 0.07
var control_characters = PackedStringArray(["%"])

# Called when the node enters the scene tree for the first time.
func _ready():
	say("charming superflous valorous #w#chimichangas#w# rustle gloriously in all weather conditions, regardless")

func letter_elements():
	var arr = []
	arr.append_array($letters/top.get_children())
	arr.append_array($letters/middle.get_children())
	arr.append_array($letters/bottom.get_children())
	return arr

func _compress_control_characters(string):
	return string.replace("#w#", "%")

func _adjusted_length(string):
	# counts length, ignoring any control characters
	for character in control_characters:
		string = string.replace(character, "")
	return string.length()

func say(string):
	clear()
	
	string = _compress_control_characters(string)
	print(string)
	
	var rows = PackedStringArray(["", "", "", ""]) #top, middle, bottom, o'erflow
	var current_row = 0
	
	# slice everything into three lines, wrapping words (this is a very rudimentary word-wrap)
	var words = string.split(" ")
	print(words)
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
	
	print(rows)
	var finalstring = "".join(rows)
	
	var counter = 0
	var wiggleflag = false
	var letters = letter_elements()
	
	for character in finalstring:
		var child = letters[counter]
		if String(character) == "%":
			wiggleflag = !wiggleflag
		else:
			child.setChar(character)
			if wiggleflag:
				child.wiggle()
			if character != " ":
				await get_tree().create_timer(default_speed).timeout
			counter = counter + 1

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
