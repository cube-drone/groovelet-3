extends NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready():
	windows()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func default():
	texture = load("res://sprites/ui/earthbound-box.png")

func windows():
	texture = load("res://sprites/ui/winbox.png")
