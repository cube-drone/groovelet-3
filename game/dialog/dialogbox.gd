extends Node2D

var line_length = 34
var default_speed = 0.07
var pause_time = 1.0
var NEWLINE_CODE = "%n"

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
# 1 - oth (teal)
#
# ## Events
# p - pause for pause_time seconds
# n - newline
# 
# e.g.: %Wrs% (slow WIGGLE rainbow)

# Called when the node enters the scene tree for the first time.
func _ready():
	#await say("%wr%ROYAL RAINBOW beeeoooooowwwww")
	await say("%0%zariel%0% %1%oth%1% %2%cystam%2% %3%kiro%3% %4%audient%4% %5%mersenne%5% %6%world%6% %7%path%7% %8%curopal%8% %9%blit%9% %a%stacks%a% %b%misk%b% ")
	#await say("this %j6%coffee%j6% is so %ws6%smoooooth%ws6% %p% %n%this %J6%COFFEE%J6% is so %W6%SMOOOOOTH%W6%")
	#await say("then the keyboard was like %k%clacka clacka clacka clacka %p% ker-ching!%k% %p%")
	#await say("and then he said %W%WHOOOAAAAH HAH%W%!!! %p%")
	#await say("normal %f%fast fast fast%f% %s%slow slow slow%s% and then %p%stop")
	#await say("the radio this morning promised %w%ten tonnes of cheese%w% to the highest bidder")
	#await say("charming superflous valorous %w%chimichangas%w% rustle gloriously in all weather conditions, regardless")



# poison, fire, ice words
# todo: colors
# todo: letters swing
# todo: letters vanish in
# todo: angle ( a little bit different every time ? )
# todo: the whole dialog box gets whacked and all of the letters come a little loose
# todo: little extra time after a comma or period
# todo: "angry", "embarrassed", "sad", "frosty", "clever", "smug", "goofy", 
# todo: multi-page "say" commands for long sentences
# todo:  %N% as a page break
# todo: special characters <3 :) :P ;)
# todo: "advance" button
# todo: appear animation
# todo: profile pic
# todo: changeable background
# todo: backspace
# todo: "character set": characters might talk at different speed or with different inflections and we want to know how we can reflect that in the text box


func letter_elements():
	var arr = []
	arr.append_array($letters/top.get_children())
	arr.append_array($letters/middle.get_children())
	arr.append_array($letters/bottom.get_children())
	return arr

func _adjusted_length(string):
	# counts length, ignoring any control characters
	var newstring = ""
	var command_mode = false
	for character in string:
		if command_mode:
			if String(character) == "%":
				command_mode = false
		elif String(character) == "%":
			command_mode = true
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
	var counter = 0
	var command_mode = false
	var fast_flag = false
	var slow_flag = false
	var wiggle_flag = false
	var wobble_flag = false
	var jitter_flag = false
	var jutter_flag = false
	var kachunk_flag = false
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
	var letters = letter_elements()
	
	for character in string:
		if(counter > letters.size() - 1):
			print ("Warning! Phrase exceeds maximum size: ", string)
			pass
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
				print("doof")
				zariel_flag = !zariel_flag
				print("zflag: ", zariel_flag)
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
			elif character == "p":
				await get_tree().create_timer(pause_time).timeout
			elif character == "%":
				command_mode = false
			else:
				print("Unknown control character: ", character)
		elif String(character) == "%":
			command_mode = true
		else:
			var child = letters[counter]
			child.setChar(character)
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
			if rainbow_flag:
				child.rainbow()
			if zariel_flag:
				print("boof")
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
			if character != " ":
				var speed = default_speed
				if fast_flag:
					speed = speed * 0.3
				if slow_flag:
					speed = speed * 2	
				await get_tree().create_timer(speed).timeout
			counter = counter + 1

func say(string):
	clear()
	var wrapped_string = _wordwrap(string)
	await _display(wrapped_string)

func clear():
	for child in letter_elements():
		child.setChar(" ")

func aaaa():
	for child in letter_elements():
		child.setChar("a")

func wobble():
	for child in letter_elements():
		child.wobble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
