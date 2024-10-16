extends Node

func swap_scenes(scene: String):
	var next_scene = load(scene)
	for child in self.get_children():
		if child.is_in_group("persist"):
			continue
		child.queue_free()
	
	var instance = next_scene.instantiate()
	add_child(instance)
