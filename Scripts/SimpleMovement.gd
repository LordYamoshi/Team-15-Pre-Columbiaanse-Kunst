extends Node


func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	
	var direction = (target_position - get_parent().position).normalized()
	var movement_vector = direction * get_parent().speed * delta
	return movement_vector
