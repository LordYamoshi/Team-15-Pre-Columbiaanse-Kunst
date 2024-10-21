extends CharacterBody3D

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(player.position, delta * 2.5)
