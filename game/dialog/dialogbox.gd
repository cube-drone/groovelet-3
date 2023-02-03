extends Node2D

## LINE LENGTH
var line_length = 34		# this is how many actual characters fit per line

## TIMING
@export var start_delay_seconds = 0.1	# all of the reset animations actually take some time to execute, this gives them time to run before we start rolling text 
@export var end_delay_seconds = 2		# this is just to give you some time to read
@export var default_speed = 0.07		# the default number of seconds between characters
@export var pause_time = 0.8			# how long a %p% should take

## CODES
var NEWLINE_CODE = "%n"			# the character that kicks off a newline

@export var letter_top_left_x = 8
@export var letter_top_left_y = 13
@export var letter_bottom_right_x = 14
@export var letter_bottom_right_y = 14
@export var letter_width = 5
@export var letter_height = 7
@export var leading_height = 2 # space between vertical lines
@export var kerning_width = 2 # space between horizontal letters

@export var letter_scene: PackedScene
var letters = []

# Command Language:
# everything between %% is a command
#
# ## Toggles
# r - rainbow
# k - kachunk
# w - wiggle
# W - WIGGLE
# j - jitter
# J - JITTER
# f - fast
# s - slow
# 
# ## Colors
# 0 - zariel
# 1 - oth (teal)
# 2 - cystam
# 3 - kiro
# 4 - audient
# 5 - mersenne
# 6 - world
# 7 - path
# 8 - curopal
# 9 - blit
# a - stacks
# b - misk
# X - black
# 
# ## Events
# p - pause for pause_time seconds
# n - newline
# 
# e.g.: %Wrs% (slow WIGGLE rainbow)


# Called when the node enters the scene tree for the first time.
func _ready():
	_build()
	await clear()
	await hide()
	$NinePatchRect.scale.y = 0
	
	demo()
	
func _build():
	# fill the CharacterContainer with animatable letters
	var x = $NinePatchRect.position.x + letter_top_left_x
	var y = $NinePatchRect.position.y + letter_top_left_y
	var w = $NinePatchRect.size.x - letter_bottom_right_x
	var h = $NinePatchRect.size.y - letter_bottom_right_y
	var current_x = x
	var current_y = y
	var line_length_counter = 0
	
	while current_y < h:
		## put letter in current position
		var letter = letter_scene.instantiate()
		letter.position = $NinePatchRect.position
		letter.position.x = letter.position.x + current_x
		letter.position.y = letter.position.y + current_y
		$LetterContainer.add_child(letter)
		letters.push_back(letter)
		
		## advance to next position
		line_length_counter += 1
		current_x = current_x + letter_width + kerning_width
		if current_x > w:
			line_length = line_length_counter
			line_length_counter = 0
			current_x = x
			current_y = current_y + letter_height + leading_height
		

func demo():
	await get_tree().create_timer(5).timeout
	
	await say("charming superflous valorous %w%chimichangas%w% rustle gloriously in all weather conditions, regardless")
	await say("the radio this morning promised %w4%ten tonnes of cheese%w4% to the highest bidder")
	await say("normal %f%fast fast fast%f% %s%slow slow slow%s% and then %p%stop")
	await say("Hello, there - how are you? %n%I'm doing okay, thanks!")
	await say("and then he said %W%WHOOOAAAAH HAH%W%! %p%")
	await say("%0%zariel%0% %1%oth%1% %2%cystam%2% %3%kiro%3% %4%audient%4% %5%mersenne%5% %6%world%6% %7%path%7% %8%curopal%8% %9%blit%9% %a%stacks%a% %b%misk%b% %X%black%X%")
	await say("hi :> :0 :1 :2 :3 :4 :5 :6 :7 :8 :9 :a :b :) :| :( :w :n :N")
	await say(":| %r%:>%r% %0%:0%0% %1%:1%1% %2%:2%2% %3%:3%3% %4%:4%4% %5%:5%5% %6%:6%6% %7%:7%7% %8%:8%8% %9%:9%9% %a%:a%a% %b%:b%b% %X%:)%X% %W%:n:N%W% :|")
	
	await say("this %j6%coffee%j6% is so %ws6%smoooooth%ws6% %p% %n%this %J6%COFFEE%J6% is so %W6%SMOOOOOTH%W6%")
	await say("then the keyboard was like %k%clacka clacka clacka clacka %p% ker ching!%k% %p%")
	await say("%wr%ROYAL RAINBOW beeeoooooowwwww")
	
	await say("Oh! %j%ouch!%j% - these chili peppers are hot hot %Fj%hooot%Fj%!")
	await say("%G%BE NOT AFRAID%G%")
	await say("%Gr%BE A LITTLE AFRAID%Gr%")
	await say("%BW%h i, i'm  a  f i s h y  f i s h%BW%")
	
	await say("%Bwr%c l o w n  b u l l s h i t%Bwr%")

func appear():
	show()
	clear()
	$AnimationPlayer.play("appear")
	await $AnimationPlayer.animation_finished

func disappear():
	pass

# poison, fire, ice words
# todo: letters swing
# todo: letters vanish in
# todo: angle ( a little bit different every time ? )
# todo: the whole dialog box gets whacked and all of the letters come a little loose
# todo: little extra time after a comma or period
# todo: "angry", "embarrassed", "sad", "frosty", "clever", "smug", "goofy", 
# todo: multi-page "say" commands for long sentences
# todo:  %N% as a page break
# todo: "advance" button
# todo: appear animation
# todo: profile pic
# todo: changeable background
# todo: backspace
# todo: "character set": characters might talk at different speed or with different inflections and we want to know how we can reflect that in the text box

func _letter_elements():
	return letters

func _adjusted_length(string):
	# counts length, ignoring any control characters
	var newstring = ""
	var command_mode = false
	for character in string:
		if command_mode:
			if character == "%":
				command_mode = false
		elif character == "%":
			command_mode = true
		elif character == ":":
			pass
		else:
			newstring = newstring + character
	return newstring.length()

func _wordwrap(string):
	# slice everything into three lines, wrapping words (this is a very rudimentary word-wrap)
	var rows = PackedStringArray(["", "", "", ""]) #top, middle, bottom, o'erflow
	var current_row = 0
	
	var words = string.split(" ")
	var current_word = words[0]
	for word in words:
		var current_line = rows[current_row]
		var prospective_line_length = _adjusted_length(current_line) + _adjusted_length(word)
			
		if prospective_line_length < line_length && !NEWLINE_CODE in word:
			rows[current_row] = rows[current_row] + word + " "
		elif prospective_line_length == line_length && !NEWLINE_CODE in word:
			rows[current_row] = rows[current_row] + word
		else:
			while _adjusted_length(rows[current_row]) < line_length:
				rows[current_row] = rows[current_row] + " "
			current_row = current_row + 1
			rows[current_row] = rows[current_row] + word + " "
	
	var word_wrapped_string = "".join(rows)
	return word_wrapped_string

func _display(string):
	print("displaying: ", string)
	
	var counter = 0
	var command_mode = false
	# speed
	var fast_flag = false
	var slow_flag = false
	# fx
	var wiggle_flag = false
	var wobble_flag = false
	var jitter_flag = false
	var jutter_flag = false
	var kachunk_flag = false
	var glow_flag = false
	var fire_flag = false
	var bubble_flag = false
	var sparkle_flag = false
	#colors
	var rainbow_flag = false
	var zariel_flag = false; #teal
	var oth_flag = false #turquoise
	var cystam_flag = false #green
	var kiro_flag = false #lime
	var audient_flag = false #lemon
	var mersenne_flag = false #orange
	var world_flag = false #red
	var path_flag = false #pink
	var curopal_flag = false #magenta
	var blit_flag = false #purple
	var stacks_flag = false #blue
	var misk_flag = false #sky
	var black_flag = false
	#special characters
	var special_character_mode = false
	var special_character = ""
	var wink_mode = false
	
	var letters = _letter_elements()
	
	await get_tree().create_timer(start_delay_seconds).timeout
	
	for character in string:
		if(counter > letters.size() - 1):
			print ("Warning! Phrase exceeds maximum size: ", string)
			break
		elif character == ":" && !special_character_mode:
			special_character_mode = true
		elif character == "%" && !command_mode:
			command_mode = true
		elif command_mode:
			if character == "w":
				wiggle_flag = !wiggle_flag
			elif character == "W":
				wobble_flag = !wobble_flag
			elif character == "j":
				jitter_flag = !jitter_flag
			elif character == "J":
				jutter_flag = !jutter_flag
			elif character == "k":
				kachunk_flag = !kachunk_flag
			elif character == "r":
				rainbow_flag = !rainbow_flag
			elif character == "f":
				fast_flag = !fast_flag
			elif character == "s":
				slow_flag = !slow_flag
			elif character == "0":
				zariel_flag = !zariel_flag
			elif character == "1":
				oth_flag = !oth_flag
			elif character == "2":
				cystam_flag = !cystam_flag
			elif character == "3":
				kiro_flag = !kiro_flag
			elif character == "4":
				audient_flag = !audient_flag
			elif character == "5":
				mersenne_flag = !mersenne_flag
			elif character == "6":
				world_flag = !world_flag
			elif character == "7":
				path_flag = !path_flag
			elif character == "8":
				curopal_flag = !curopal_flag
			elif character == "9":
				blit_flag = !blit_flag
			elif character == "a":
				stacks_flag = !stacks_flag
			elif character == "b":
				misk_flag = !misk_flag
			elif character == "X":
				black_flag = !black_flag
			elif character == "B":
				bubble_flag = !bubble_flag
			elif character == "F":
				fire_flag = !fire_flag
			elif character == "S":
				sparkle_flag = !sparkle_flag
			elif character == "G":
				glow_flag = !glow_flag
			elif character == "p":
				await get_tree().create_timer(pause_time).timeout
			elif character == "%":
				command_mode = false
			else:
				print("Unknown control character: ", character)
		else:
			var child = letters[counter]
			
			if special_character_mode:
				special_character_mode = false
				if character == "(":
					child.setSpecial(":(")
				elif character == "|":
					child.setSpecial(":|")
				elif character == ")":
					child.setSpecial(":)")
				elif character == "w":
					child.setSpecial(";)")
				elif character == "n":
					child.setSpecial("note")
				elif character == "N":
					child.setSpecial("doublenote")
				elif character == ">":
					child.setSpecial("heart")
				elif character == "\\":
					child.setChar(":") #escape the :
				else:
					child.setSpecial(character)
			else:
				child.setChar(character)
			
			# set character FX
			if character != " ":
				if wiggle_flag:
					child.wiggle()
				if wobble_flag:
					child.wobble()
				if jitter_flag:
					child.jitter()
				if jutter_flag:
					child.jutter()
				if kachunk_flag:
					child.kachunk()
				if glow_flag:
					child.glow()
				if bubble_flag:
					child.bubble()
				if fire_flag:
					child.fire()
				if sparkle_flag:
					child.sparkle()
				if rainbow_flag:
					child.rainbow()
				if zariel_flag:
					child.zariel()
				if oth_flag:
					child.oth()
				if cystam_flag:
					child.cystam()
				if kiro_flag:
					child.kiro()
				if audient_flag:
					child.audient()
				if mersenne_flag:
					child.mersenne()
				if world_flag:
					child.world()
				if path_flag:
					child.path()
				if curopal_flag:
					child.curopal()
				if blit_flag:
					child.blit()
				if stacks_flag:
					child.stacks()
				if misk_flag:
					child.misk()
				if black_flag:
					child.black()
			
			# timing
			if character != " ":
				var speed = default_speed
				if character == "," || character == "-":
					speed = speed * 4
				if character == "." || character == "-" || character == "?" || character == "!":
					speed = pause_time
				if fast_flag:
					speed = speed * 0.3
				if slow_flag:
					speed = speed * 2	
				await get_tree().create_timer(speed).timeout
			
			counter = counter + 1
			
	await get_tree().create_timer(end_delay_seconds).timeout

func say(string):
	await appear()
	await clear()
	var wrapped_string = _wordwrap(string)
	await _display(wrapped_string)

func clear():
	for child in _letter_elements():
		child.clear()

func aaaa():
	for child in _letter_elements():
		child.setChar("a")

func wobble():
	for child in _letter_elements():
		child.wobble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
