extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setSpecial(specialCharacter):
	if specialCharacter == "<3" || specialCharacter == "heart":
		$Sprite2D.frame = 2
	elif specialCharacter == ":)":
		$Sprite2D.frame = 12
	elif specialCharacter == ";)":
		$Sprite2D.frame = 14
	elif specialCharacter == ":(":
		$Sprite2D.frame = 16
	elif specialCharacter == ":|":
		$Sprite2D.frame = 18
	elif specialCharacter == "note" || specialCharacter == "n":
		$Sprite2D.frame = 20
	elif specialCharacter == "doublenote" || specialCharacter == "N":
		$Sprite2D.frame = 22
	elif specialCharacter == "1" || specialCharacter == "oth":
		$Sprite2D.frame = 24
	elif specialCharacter == "2" || specialCharacter == "cystam":
		$Sprite2D.frame = 26
	elif specialCharacter == "3" || specialCharacter == "kiro":
		$Sprite2D.frame = 28
	elif specialCharacter == "4" || specialCharacter == "audient":
		$Sprite2D.frame = 30
	elif specialCharacter == "5" || specialCharacter == "mersenne":
		$Sprite2D.frame = 32
	elif specialCharacter == "6" || specialCharacter == "world":
		$Sprite2D.frame = 34
	elif specialCharacter == "7" || specialCharacter == "path":
		$Sprite2D.frame = 36
	elif specialCharacter == "8" || specialCharacter == "curopal":
		$Sprite2D.frame = 38
	elif specialCharacter == "9" || specialCharacter == "blit":
		$Sprite2D.frame = 40
	elif specialCharacter == "a" || specialCharacter == "stacks":
		$Sprite2D.frame = 42
	elif specialCharacter == "b" || specialCharacter == "misk":
		$Sprite2D.frame = 44
	elif specialCharacter == "0" || specialCharacter == "zariel":
		$Sprite2D.frame = 46
	
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
	$Sprite2D.modulate = Color("#ffffff")
	$Sprite2D.frame = 3
	$Sprite2D/SpriteAnimation.play("RESET")
	$Character.text = " "

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

func bubble():
	$Sprite2D/SpriteAnimation.play("bubble")

func fire():
	$Sprite2D/SpriteAnimation.play("flame")

func glow():
	$Sprite2D/SpriteAnimation.play("glow")

func sparkle():
	$Sprite2D/SpriteAnimation.play("sparkle")

func zariel():
	$Character/ColorAnimation.play("zariel")
	$Character.modulate = Color("#01fff8")
	$Sprite2D.modulate = Color("#01fff8")

func oth():
	$Character/ColorAnimation.play("oth")
	$Character.modulate = Color("#01ff7f")
	$Sprite2D.modulate = Color("#01ff7f")

func cystam():
	$Character/ColorAnimation.play("cystam")
	$Character.modulate = Color("#03f80c")
	$Sprite2D.modulate = Color("#03f80c")

func kiro():
	$Character/ColorAnimation.play("kiro")
	$Character.modulate = Color("#82fe00")
	$Sprite2D.modulate = Color("#82fe00")

func audient():
	$Character/ColorAnimation.play("audient")
	$Character.modulate = Color("#f3ff00")
	$Sprite2D.modulate = Color("#f3ff00")

func mersenne():
	$Character/ColorAnimation.play("mersenne")
	$Character.modulate = Color("#ff9b00")
	$Sprite2D.modulate = Color("#ff9b00")

func world():
	$Character/ColorAnimation.play("world")
	$Character.modulate = Color("#ff0000")
	$Sprite2D.modulate = Color("#ff0000")

func path():
	$Character/ColorAnimation.play("path")
	$Character.modulate = Color("#ff007e")
	$Sprite2D.modulate = Color("#ff007e")

func curopal():
	$Character/ColorAnimation.play("curopal")
	$Character.modulate = Color("#ff00e6")
	$Sprite2D.modulate = Color("#ff00e6")

func blit():
	$Character/ColorAnimation.play("blit")
	$Character.modulate = Color("#8500ff")
	$Sprite2D.modulate = Color("#8500ff")

func stacks():
	$Character/ColorAnimation.play("stacks")
	$Character.modulate = Color("#1603ff")
	$Sprite2D.modulate = Color("#1603ff")

func misk():
	$Character/ColorAnimation.play("misk")
	$Character.modulate = Color("#0366ff")
	$Sprite2D.modulate = Color("#0366ff")

func black():	
	$Character/ColorAnimation.play("black")
	$Character.modulate = Color("#000000")
	$Sprite2D.modulate = Color("#000000")
