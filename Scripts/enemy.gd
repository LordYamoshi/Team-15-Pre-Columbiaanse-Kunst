extends CharacterBody3D

@export var movement_pattern : Resource
var pattern_instance = null
var player
var speed = 25;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().player
	if movement_pattern:
		pattern_instance = movement_pattern.new()
		add_child(pattern_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if pattern_instance:
		var movement_vector = pattern_instance.move_towards_player(player.position, delta)
		move_and_collide(movement_vector)
