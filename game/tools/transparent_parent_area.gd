# The purpose of the transparent-parent-area is that you can place it as a child to any element;
#	Then, place an Area2D as its only child
#	If the player walks into the Area2D, the parent's opacity will be cut in half. 
#	This is intended to be used to build scene elements that are opaque until you walk "under" them
extends Node2D

var base_opacity = 1.0
var transparent_opacity = 0.6
var current_opacity = base_opacity

var t = 0
var ta = 0
var animation_length_seconds = 0.3

var animating = false
var going_transparent = false
var going_opaque = false

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
	
	# for good measure, make sure that we're in the "non-transparent" state

## we'll go bake an easing function library in a moment, for now let's just make linear and cubic our boys
func linear(x):
	return x

func cubic(x):
	return x*x*x
	
func easeInOutElastic(x):
	var c5 = (2 * 3.14) / 4.5
	if(x <= 0):
		return 0.0
	if(x >= 1):
		return 1.0
	if(x < 0.5):
		return -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2.0
	if(x >= 0.5):
		return (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2.0 + 1.0

func normalize(t, delta, animation_length_seconds):
	var ta = t + delta / animation_length_seconds 
	if ta >= 1:
		return 1.0
	if ta <= 0:
		return 0.0
	return ta

func easing(x):
	return cubic(x)

func _process(delta):
	if not animating:
		return
	else:
		t = normalize(t, delta, animation_length_seconds)
		ta = easing(t)
		if t >= 1:
			animating = false
							
		if going_transparent:
			get_parent().modulate.a = transparent_animation(ta)
			if not animating:
				going_transparent = false
		if going_opaque:
			get_parent().modulate.a = opaquify_animation(ta)
			if not animating:
				going_opaque = false

func transparent_animation(a):
	# from base_opacity to transparent_opacity
	var difference = base_opacity - transparent_opacity
	var animated_difference = a * difference
	return base_opacity - animated_difference

func opaquify_animation(a):
	# from transparent_opacity to base_opacity
	var difference = base_opacity - transparent_opacity
	var animated_difference = a * difference
	return transparent_opacity + animated_difference

func transparentify_parent():
	animating = true
	t = 0.0
	going_opaque = false
	going_transparent = true
	#get_parent().modulate.a = 0.6

func hide_visible_children():
	for child in get_children():
		if "visible" in child.name or "Visible" in child.name:
			child.hide()
		if "transparent" in child.name or "Transparent" in child.name:
			child.show()

func opaquify_parent():
	animating = true
	t = 0.0
	going_opaque = true
	going_transparent = false
	#get_parent().modulate.a = 1.0

func show_visible_children():
	for child in get_children():
		if "visible" in child.name or "Visible" in child.name:
			child.show()
		if "transparent" in child.name or "Transparent" in child.name:
			child.hide()

func toggle_on():
	transparentify_parent()
	hide_visible_children()

func toggle_off():
	opaquify_parent()
	show_visible_children()

func _on_body_entered(body):
	if body is CharacterBody2D:	
		toggle_on()

func _on_body_exited(body):
	if body is CharacterBody2D:	
		toggle_off()
