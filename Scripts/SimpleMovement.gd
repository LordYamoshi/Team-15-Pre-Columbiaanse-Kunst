extends Node

var min_distance_from_player = 2.0

func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	var direction = (target_position - get_parent().position).normalized()
	var distance_to_player = get_parent().position.distance_to(target_position)
	
	if distance_to_player > min_distance_from_player:
		var movement_vector = direction * get_parent().speed * delta
		return movement_vector
	else:
		return Vector3.ZERO
