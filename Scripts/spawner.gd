extends Node3D

@export var player: CharacterBody3D
var enemy = preload("res://Scenes/enemy.tscn")

func _on_spawn_timer_timeout() -> void:
	var instance = enemy.instantiate()
	instance.position = (player.position + Vector3(0, 0, 30)).rotated(Vector3.UP, randf_range(0, 360))
	add_child(instance)
