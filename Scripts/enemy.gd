extends CharacterBody3D

@export var movement_pattern : Resource
var pattern_instance = null
var player
var speed = 2.5#25;

signal defeated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().player
	if movement_pattern:
		pattern_instance = movement_pattern.new()
		add_child(pattern_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if pattern_instance:
		if movement_pattern.resource_path == "res://Scripts/RandomMovement.gd":
			set_random_movement_pattern()
		else:
			var movement_vector = pattern_instance.move_towards_player(player.position, delta)
			move_and_collide(movement_vector)


func set_random_movement_pattern() -> void:
	# Choose a random movement script
	var random_movement_script = preload("res://Scripts/RandomMovement.gd")
	
	var random_movement_instance = random_movement_script.new()#
	
	random_movement_instance.set_random_movement_pattern(self)
	
	if movement_pattern:
		pattern_instance = movement_pattern.new()
		get_child(1).texture = pattern_instance.sprite
		add_child(pattern_instance)

func die():
	emit_signal("defeated")
	queue_free()
