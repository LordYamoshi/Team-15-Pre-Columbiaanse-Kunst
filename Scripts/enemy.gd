extends CharacterBody3D

var player
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().player
	#print(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = position.direction_to(player.position)
	#position = position.move_toward(player.position, delta * 2.5)
	position = position + direction * delta * 2.5
