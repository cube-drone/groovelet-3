# The purpose of the transparent-parent-area is that you can place it as a child to any element;
#	Then, place an Area2D as its only child
#	If the player walks into the Area2D, the parent's opacity will be cut in half. 
#	This is intended to be used to build scene elements that are opaque until you walk "under" them
extends Node2D

func _ready():
	# get parent and child, check to make sure that they are sane
	var parent = get_parent()
	if(parent.modulate == null):
		push_error(parent)
		push_error("transparent-parent-area created with a parent that cannot be modulated in opacity")
	var child = get_child(0)
	if(child == null):
		push_error("transparent-parent-area created without a child")
	if(not child is Area2D):
		push_error(child)
		push_error("transparent-parent-area can only have an Area2D as a child, not whatever this is")
	
	child.body_entered.connect(_on_body_entered)
	child.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:	
		get_parent().modulate.a = 0.6

func _on_body_exited(body):
	if body is CharacterBody2D:	
		get_parent().modulate.a = 1.0
