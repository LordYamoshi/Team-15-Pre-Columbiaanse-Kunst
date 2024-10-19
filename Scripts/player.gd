extends CharacterBody3D

#player nodes/onready vars
@onready var head = $Head
@onready var camera = $Head/Camera3D

const mouse_sensitivity = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#mouse look logic
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89)) #89 broken!!
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
