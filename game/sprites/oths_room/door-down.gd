extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_door():
	$AnimationPlayer.play("open")

func close_door():
	$AnimationPlayer.play("close")

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		open_door()

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		close_door()
