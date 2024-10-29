extends Node

var move_towards_player = preload("res://Scripts/SimpleMovement.gd")
var zigzag_movement = preload("res://Scripts/ZigZagMovement.gd")
var circle_movement = preload("res://Scripts/CircleAroundPlayerMovement.gd")
var updown_movement = preload('res://Scripts/UpDownMovement.gd')

# Array to store movement script options
var movement_scripts = [move_towards_player, zigzag_movement, circle_movement, updown_movement]

func set_random_movement_pattern(enemy):
	# Choose a random script from the array
	var random_script = movement_scripts.pick_random()

	enemy.movement_pattern = random_script
