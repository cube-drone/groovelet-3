extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setChar(c):
	$Character/ColorAnimation.play("RESET")
	$Character/ScaleAnimation.play("RESET")
	$Character/PositionAnimation.play("RESET")
	$Character.text = c

func clear():
	$Character/ColorAnimation.play("RESET")
	$Character/ScaleAnimation.play("RESET")
	$Character/PositionAnimation.play("RESET")
	$Character.modulate = Color("#ffffff")

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

func zariel():
	$Character/ColorAnimation.play("zariel")
	$Character.modulate = Color("#01fff8")

func oth():
	$Character/ColorAnimation.play("oth")
	$Character.modulate = Color("#01ff7f")

func cystam():
	$Character/ColorAnimation.play("cystam")
	$Character.modulate = Color("#03f80c")

func kiro():
	$Character/ColorAnimation.play("kiro")
	$Character.modulate = Color("#82fe00")

func audient():
	$Character/ColorAnimation.play("audient")
	$Character.modulate = Color("#f3ff00")

func mersenne():
	$Character/ColorAnimation.play("mersenne")
	$Character.modulate = Color("#ff9b00")

func world():
	$Character/ColorAnimation.play("world")
	$Character.modulate = Color("#ff0000")

func path():
	$Character/ColorAnimation.play("path")
	$Character.modulate = Color("#ff007e")

func curopal():
	$Character/ColorAnimation.play("curopal")
	$Character.modulate = Color("#ff00e6")

func blit():
	$Character/ColorAnimation.play("blit")
	$Character.modulate = Color("#8500ff")

func stacks():
	$Character/ColorAnimation.play("stacks")
	$Character.modulate = Color("#1603ff")

func misk():
	$Character/ColorAnimation.play("misk")
	$Character.modulate = Color("#0366ff")

