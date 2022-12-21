extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:	
		print("firing ze missiles")
		print(body)
		$wall.modulate.a = 0.6


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:	
		print("firing ze missiles")
		print(body)
		$wall.modulate.a = 1
