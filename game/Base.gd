extends CharacterBody2D

var speed = 70
var walk_speed = 70
var run_speed = 140
var run = false
var direction = 'down'
var last_input_direction = null
var last_run = null

func get_input():
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
		set_direction(input_direction)
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
	
func set_direction(input_direction):
	$AnimationPlayer.play("reset")
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

func _physics_process(delta):
	get_input()
	move_and_slide()
