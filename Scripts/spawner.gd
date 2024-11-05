extends Node3D

@export var player : CharacterBody3D
#Variables
@export var wave_data : Array #Array of dictionaries with enemy type and count per wave
@export var time_between_waves :float = 1.0 #time between each wave
@export var spawn_interval :float = 1.0 # Spawn interval between each enemy

var current_wave = 0 # To keep track of what wave it is
var enemies_remaining = 0 #To keep track of how many enemies are left to spawn
var enemies_alive = 0 #To keep track of all the enemeis alive
var wave_active = false #Checks if wave is currently active

#Timer for spawning and wave delayik mo
var spawn_timer
var wave_timer

func _ready():
	#Initialize the timers
	spawn_timer = Timer.new()
	spawn_timer.name = "Spawn_Timer"
	spawn_timer.connect("timeout", Callable(self, "on_spawn_enemy"))
	add_child(spawn_timer)
	
	wave_timer = Timer.new()
	wave_timer.name = "Wave_Timer"
	wave_timer.connect("timeout", Callable(self, "on_start_wave"))
	add_child(wave_timer) 
	
	start_wave()
	
func start_wave():
	if current_wave < wave_data.size():
		var wave_info = wave_data[current_wave]
		enemies_remaining = wave_info["count"]
		enemies_alive = 0
		wave_active = true
		current_wave += 1
		spawn_timer.start(spawn_interval)
		print("Wave ", current_wave, " started with " , enemies_remaining, " enemies")
	else:
		## hier verplaatsen naar einde game!!
		get_parent().get_parent().swap_scenes("res://Scenes/cutscene_handler_outro.tscn")
		print("All waves completed!")
		
func on_spawn_enemy():
	if enemies_remaining > 0:
		var wave_info = wave_data[current_wave -1]
		var enemy_scene = wave_info["enemy"]
		var enemy_instance = enemy_scene.instantiate()
		add_child(enemy_instance)
		enemy_instance.position = (player.position + Vector3(0, 0, 40)).rotated(Vector3.UP, randf_range(0, 360))
		enemy_instance.connect("defeated", Callable(self, "on_enemy_defeated"))
		enemies_remaining -= 1
		enemies_alive += 1
		print("Spawned enemy, enemies remaining to spawn: ", enemies_remaining, " active enemies: ", enemies_alive)
	else:
		spawn_timer.stop()
		if(enemies_alive == 0):
			wave_active = false
			print("Wave completed, starting next wave in ", time_between_waves, " seconds")
			wave_timer.start(time_between_waves)
		
func on_enemy_defeated():
	# This function is called when an enemy is defeated
	enemies_alive -= 1
	print("Enemy defeated, active enemies remaining: ", enemies_alive)
	if enemies_alive == 0 and enemies_remaining == 0 and wave_active:
		wave_active = false
		print("All enemies defeated for Wave ", current_wave,  " starting next wave.")
		wave_timer.start(time_between_waves)
		
func on_start_wave():
	if !wave_active:
		print("Starting Next wave")
		start_wave()
