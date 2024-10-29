extends Node3D

@export var player : CharacterBody3D
#Variables
@export var wave_data : Array #Array of dictionaries with enemy type and count per wave
@export var time_between_waves :float = 5.0 #time between each wave
@export var spawn_interval :float = 1.0 # Spawn interval between each enemy

var current_wave = 0 # To keep track of what wave it is
var enemies_remaining = 0 #To keep track of how many enemies are alive
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
		current_wave += 1
		wave_active = true
		spawn_timer.start(spawn_interval)
		print("Wave", current_wave, " started with " , enemies_remaining, " enemies")
	else:
		print("All waves completed!")
		
func on_spawn_enemy():
	print("test")
	if enemies_remaining > 0:
		var wave_info = wave_data[current_wave -1]
		var enemy_scene = wave_info["enemy"]
		var enemy_instance = enemy_scene.instantiate()
		add_child(enemy_instance)
		enemy_instance.position = (player.position + Vector3(0, 0, 30)).rotated(Vector3.UP, randf_range(0, 360))
		print("Spawned enemy, enemies remaining:", enemies_remaining)
	else:
		spawn_timer.stop()
		wave_active = false
		wave_timer.start(time_between_waves)
		
func on_start_wave():
	start_wave()
