extends CharacterBody3D

#player nodes/onready vars
@onready var head = $Head
@onready var camera = $Head/Camera3D

@export var crosshair_progress_bar: TextureProgressBar
@export var base_destroy_time: float = 1.2
var destroy_time: float = 1.2
var calculated_value_multiplier

var enemy_array: Array

const mouse_sensitivity = 0.15

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	calculated_value_multiplier = crosshair_progress_bar.max_value / base_destroy_time

func _input(event):
	#mouse look logic
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89)) #89 broken!!
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _process(delta: float) -> void:
	if enemy_array.size() == 0:
		destroy_time = base_destroy_time
		crosshair_progress_bar.value = 0
	if enemy_array.size() >= 1:
		destroy_time -= delta
		crosshair_progress_bar.value = calculate_progress_value()#crosshair_progress_bar.max_value - destroy_time * calculated_value_multiplier
		if destroy_time <= 0:
			for enemy in enemy_array:
				enemy.queue_free()
		

func calculate_progress_value() -> float:
	# ik ga van deze progress bar filling onzin een formule maken zodat het een ease out heeft!!
	#return crosshair_progress_bar.max_value - destroy_time * calculated_value_multiplier
	
	# Normalize destroy_time (value between 0 and 1)
	var normalized_time = 1 - (destroy_time / base_destroy_time)

	# Apply cubic ease-out
	var eased_time = 1 - pow(1 - normalized_time, 3)

	# Update the progress bar value based on the eased time
	return eased_time * crosshair_progress_bar.max_value
	
	#thank you chatgpt, ik heb wiskunde B gedaan maar ben hier te cooked voor

func _on_view_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		return
	enemy_array.append(body)
	#body.queue_free()

func _on_view_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		return
	enemy_array.erase(body)
