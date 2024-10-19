extends Node2D

func _on_start_game_button_pressed() -> void:
	get_parent().swap_scenes("res://Scenes/stage.tscn")
