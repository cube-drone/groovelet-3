extends CharacterBody2D

enum CharacterNames {DEFAULT, CYLINDER, ZARIEL}

var speed = 70
@export var walk_speed = 70
@export var run_speed = 130
@export var character = CharacterNames.DEFAULT
@export var controlled = true
@export var firefly = false
var run = false
var direction = 'down'
var last_input_direction = null
var last_run = null
var current_character = character

func _ready():
	if(!firefly):
		$Firefly.hide()
	_set_character()

func _update_character():
	if !firefly:
		$Firefly.hide()
	if firefly:
		$Firefly.show()
	if current_character != character:
		_set_character()
		current_character = character

func _set_character():
	if character == CharacterNames.DEFAULT:
		$Sprite2D.texture.diffuse_texture = load("res://spritesheets/base/default-nude.png")
		$Sprite2D.texture.normal_texture = load("res://spritesheets/base/default-nude-normals.png")
	elif character == CharacterNames.CYLINDER:
		$Sprite2D.texture.diffuse_texture = load("res://spritesheets/base/cylinder-head-nude.png")
		$Sprite2D.texture.normal_texture = load("res://spritesheets/base/cylinder-head-nude-normals.png")
	elif character == CharacterNames.ZARIEL:
		$Sprite2D.texture.diffuse_texture = load("res://spritesheets/base/base-smoother.png")
		$Sprite2D.texture.normal_texture = load("res://spritesheets/base/base-smoother-normals.png")

func _set_direction(input_direction):
	if(input_direction.x < 0 && input_direction.y < 0):
		direction = "ul"
	elif(input_direction.x < 0 && input_direction.y > 0):
		direction = "dl"
	elif(input_direction.x > 0 && input_direction.y < 0):
		direction = "ur"
	elif(input_direction.x > 0 && input_direction.y > 0):
		direction = "dr"
	elif(input_direction.x < 0):
		direction = "l"
	elif(input_direction.x > 0):
		direction = "r"
	elif(input_direction.y < 0):
		direction = "up"
	elif(input_direction.y > 0):
		direction = "down"

func _get_input():
	if(Input.is_action_pressed("run")):
		run = true
		speed = run_speed
	else:
		run = false
		speed = walk_speed
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	input_direction = input_direction.normalized()
	
	if(last_input_direction != input_direction || last_run != run):
		last_input_direction = input_direction
		last_run = run
		_set_direction(input_direction)
		$AnimationPlayer.play("RESET")
		if(input_direction.x == 0 && input_direction.y == 0):
			$AnimationPlayer.play("idle")
			pass
		else:
			if(run):
				$AnimationPlayer.play(direction+"_run")
			else:
				$AnimationPlayer.play(direction+"_walk")
		
	velocity = speed * input_direction

func _process(tick):
	_update_character()

func _physics_process(_delta):
	if(controlled):
		_get_input()
	move_and_slide()
