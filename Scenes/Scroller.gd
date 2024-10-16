extends Camera2D

@export var max_speed : float = 400.0
@export var sensitivity : float = 500.0
@export var edge_threshold: float = 100.0
@export var lerp_speed :float = 5.0
	
var target_position: Vector2

func _ready():
	target_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	
	var move_direction = Vector2()
	var speed_multiplier = Vector2(0,0) 
	
	if mouse_pos.x > screen_size.x - edge_threshold:
		move_direction.x += 1
		speed_multiplier.x = (mouse_pos.x - (screen_size.x - edge_threshold))
	elif mouse_pos.x < edge_threshold:
		move_direction.x -= 1
		speed_multiplier.x = (edge_threshold / mouse_pos.x)
		
		
	var speed = Vector2(move_direction.x * max_speed * speed_multiplier.x,0)
	target_position  += speed * delta
	
	position = position.lerp(target_position, lerp_speed * delta)
	
