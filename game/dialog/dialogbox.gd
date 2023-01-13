extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	say("there once was a man on movember - who's mustache lasted 'til december")

func letter_elements():
	var arr = []
	arr.append_array($letters/top.get_children())
	arr.append_array($letters/middle.get_children())
	arr.append_array($letters/bottom.get_children())
	return arr

func say(string):
	clear()
	var counter = 0
	var listifiedString = []
	
	for child in letter_elements():
		if(counter <= string.length() - 1):
			child.setChar(string[counter])
			child.wiggle()
			await get_tree().create_timer(0.15).timeout
			
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
