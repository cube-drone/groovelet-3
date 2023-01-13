extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	say("hi")

func say(string):
	clear()
	var counter = 0
	var listifiedString = []
	
	for char in string:
		listifiedString.push_back(char)

	for child in $letters/top.get_children():
		if(counter <= string.length() - 1):
			child.text = listifiedString[counter]
		else:
			child.text = " "
		counter = counter + 1
	for child in $letters/middle.get_children():
		counter = counter + 1
		child.text = " "
	for child in $letters/bottom.get_children():
		counter = counter + 1
		child.text = " "
	pass

func clear():
	for child in $letters/top.get_children():
		child.text = " "
	for child in $letters/middle.get_children():
		child.text = " "
	for child in $letters/bottom.get_children():
		child.text = " "

func aaaa():
	for child in $letters/top.get_children():
		child.text = "a"
	for child in $letters/middle.get_children():
		child.text = "a"
	for child in $letters/bottom.get_children():
		child.text = "a"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
