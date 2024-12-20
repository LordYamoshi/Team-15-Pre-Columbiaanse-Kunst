extends Node

var drift_strength = 1.0
var drift_directions = ["left", "right"]

var sprite = preload('res://2D Assets/wolf.png')
var min_distance_from_player = 2.0
var random_value

func _ready() -> void:
	random_value = randi_range(0,drift_directions.size() -1)

func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	var direction = (target_position - get_parent().position).normalized()
	var distance_to_player = get_parent().position.distance_to(target_position)

	var selected_direction = drift_directions[random_value]
	
	if selected_direction == "right":
		drift_strength = 1.0
	elif selected_direction == "left":
		drift_strength = -1.0
	else:
		drift_strength = 0.0
	
	var rightward_direction = direction.cross(Vector3.UP).normalized()
		
	if distance_to_player > min_distance_from_player:
		var movement_vector = (direction + rightward_direction * drift_strength).normalized() * get_parent().speed * delta
		return movement_vector
	else:
		return Vector3.ZERO
