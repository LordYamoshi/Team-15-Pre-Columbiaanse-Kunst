extends Node

var zigzag_duration = 1#0.5
var zigzag_strength = 2 
var time_elapsed = 0.0 

var sprite = preload('res://2D Assets/spin.png')

var min_distance_from_player = 2.0

func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	var direction = (target_position - get_parent().position).normalized()
	
	time_elapsed += delta
	
	var zigzag_offset = 0.0
	if time_elapsed < zigzag_duration:
		zigzag_offset = zigzag_strength
	elif time_elapsed < zigzag_duration * 2:
		zigzag_offset = -zigzag_strength
	else:
		time_elapsed = 0.0
	
	
	var zigzag_vector = direction.cross(Vector3.UP).normalized() * zigzag_offset
	
	var distance_to_player = get_parent().position.distance_to(target_position)

	if distance_to_player > min_distance_from_player:
		var movement_vector = (direction + zigzag_vector).normalized() * get_parent().speed * delta 
		return movement_vector
	else:
		return Vector3.ZERO
