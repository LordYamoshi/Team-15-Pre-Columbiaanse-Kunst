extends Node

func swap_scenes(scene: String):
	var next_scene = load(scene)
	for child in self.get_children():
		if child.is_in_group("persist"):
			continue
		child.queue_free()
	
	var instance = next_scene.instantiate()
	add_child(instance)

func load_scene(scene: String):
	var next_scene = load(scene)
	var temporary_child
	for child in self.get_children():
		if child.is_in_group("persist"):
			continue
		temporary_child = child #returns children to be cleaned
	
	var instance = next_scene.instantiate()
	add_child(instance)
	return temporary_child #returns children to be cleaned
