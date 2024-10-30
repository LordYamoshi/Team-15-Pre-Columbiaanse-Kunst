extends Node

var zigzag_duration = 1#0.5
var zigzag_strength = 2 
var time_elapsed = 0.0 

var sprite = preload('res://2D Assets/Enemy.png')

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
	
	var movement_vector = (direction + zigzag_vector).normalized() * get_parent().speed * delta 
	return movement_vector
