extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setChar(c):
	$Character.text = c
	$Character/AnimationPlayer.play("RESET")

func wobble():
	$Character/AnimationPlayer.play("wobble")

func wiggle():
	$Character/AnimationPlayer.play("wiggle")
