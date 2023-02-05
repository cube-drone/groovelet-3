extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Let two sprite_frames pass to make sure the vieport is captured.
	#await get_tree().idle_frame
	#await get_tree().idle_frame

	# Retrieve the texture and set it to the viewport quad.
	$Television/ViewportQuad.material.albedo_texture = viewport.get_texture()

var mouse_sens = 0.3
var camera_anglev=0

func _input(event):         
	if event is InputEventMouseMotion:
		$Camera3D.rotate_y(deg_to_rad(-event.relative.x*mouse_sens))
		#$Camera3D.rotate_x(deg_to_rad(-event.relative.y*mouse_sens))
		#var changev=-event.relative.y*mouse_sens
		#if camera_anglev+changev>-50 and camera_anglev+changev<50:
		#	camera_anglev+=changev
		#	$Camera3D.rotate_x(deg_to_rad(changev))
