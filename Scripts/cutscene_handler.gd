extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var next_scene: String
@export var images: Array[Texture2D] #voor de sprite2d
var current_image = 0 #array index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = images[current_image]
	#animation_player.play("transition")

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not animation_player.is_playing():
		animation_player.play("transition")

func check_next_function():
	current_image += 1
	if current_image >= images.size():
		## load next scene
		## hier eigenlijk heel ff mee wachten nog, zodat de transition afgemaakt wordt, voor nu vervang ik de afbeelding wel met een screenshot van de game ofzo LMAO
		# als je hier de gameplay scene laadt voordat je deze scene delete, dan loopt die mooi over into gameplay
		var temporary_children = get_parent().load_scene(next_scene)
		sprite.texture = load("res://2D Assets/Cutscenes/empty.png")
		await get_tree().create_timer(0.3).timeout
		temporary_children.queue_free()
	else:
		load_next_image()

func load_next_image():
	sprite.texture = images[current_image]
