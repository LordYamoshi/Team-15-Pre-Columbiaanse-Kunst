extends Node

var orbit_radius = 5.0
var orbit_speed = 1.0
var clockwise = true
var orbit_angle = 0.0


func move_towards_player(target_position: Vector3, delta: float) -> Vector3:
	orbit_angle += (orbit_speed * delta) * (1 if clockwise else -1)
	
	var offset_x = cos(orbit_angle) * orbit_radius
	var offset_z = sin(orbit_angle) * orbit_radius
	
	var orbit_position = target_position +Vector3(offset_x,0, offset_z)
	
	var direction = (orbit_position - get_parent().position).normalized()
	var movement_vector = direction * get_parent().speed * delta
	
	return movement_vector
