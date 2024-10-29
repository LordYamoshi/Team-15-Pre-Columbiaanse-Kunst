extends Node

var drift_strength = 1.0


func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	var direction = (target_position - get_parent().position).normalized()
	
	
	var rightward_direction = direction.cross(Vector3.UP).normalized()
	
	var movement_vector = (direction + rightward_direction * drift_strength).normalized() * get_parent().speed * delta
	
	return movement_vector
