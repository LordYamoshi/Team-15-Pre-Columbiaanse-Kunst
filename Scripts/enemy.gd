extends CharacterBody3D

var player
var direction
var sway_amount = 50.0
var sway_speed = 5.0
var sway_timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().player
	sway_timer = Timer.new()
	add_child(sway_timer)
	#print(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sway_offset = sin(sway_timer.time_left * sway_speed) * sway_amount
	direction = position.direction_to(player.position)
	position += direction * delta * 2.5
