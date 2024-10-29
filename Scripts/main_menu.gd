extends Node2D

func _on_start_game_button_pressed() -> void:
	## hier kan misschien nog een transition tussen
	#get_parent().swap_scenes("res://Scenes/stage.tscn")
	get_parent().swap_scenes("res://Scenes/cutscene_handler.tscn")
