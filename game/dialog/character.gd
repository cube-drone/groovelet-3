extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setChar(c):
	$Character.text = c
	$Character/ColorAnimation.play("RESET")
	$Character/ScaleAnimation.play("RESET")
	$Character/PositionAnimation.play("RESET")

func wobble():
	$Character/PositionAnimation.play("wobble")

func wiggle():
	$Character/PositionAnimation.play("wiggle")

func jitter():
	$Character/PositionAnimation.play("jitter")

func jutter():
	$Character/PositionAnimation.play("jutter")

func kachunk():
	$Character/ScaleAnimation.play("kachunk")

func rainbow():
	$Character/ColorAnimation.play("rainbow")
