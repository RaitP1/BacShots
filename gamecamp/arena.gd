extends Node2D

var zombie_count = 0
var round = 1
var boss_spawned = false
var soap_boss_packed = preload("res://boss_mobs/Soap/Boss_Soap.tscn")

func _ready():
	# Set up the timer
	var wave_timer = Timer.new()
	wave_timer.connect("timeout", _on_wave_timer_timeout)
	add_child(wave_timer)
	wave_timer.start(10.0)  # Start the first wave after 3 seconds

func spawn_zombie():
	var new_mob = preload("res://enemy_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	zombie_count += 1

func spawn_boss():
	var soap_boss = soap_boss_packed.instantiate()
	%PathFollow2D.progress_ratio = randf()
	soap_boss.global_position = %PathFollow2D.global_position
	add_child(soap_boss)
	Global.boss_alive4 = true

func _on_wave_timer_timeout():
	print("Wave ", round, " starting!")
	
	if round % 5 == 0 and not boss_spawned:
		spawn_boss()
		boss_spawned = true
	else:
		if Global.boss_alive4 == false:
			call_zombie_wave(round)
	
	round += 1
	
	# Adjust the timer for the next wave
	var next_wave_time = 10.0 + log(round)  # Adjust timing as needed
	$WaveTimer.wait_time = next_wave_time
	$WaveTimer.start()

func call_zombie_wave(current_round):
	for i in range(round(current_round * 1.5)):  # Increase the number of zombies each round
		spawn_zombie()

func _process(delta):
	if Global.boss_alive4 == false:
		boss_spawned = false
