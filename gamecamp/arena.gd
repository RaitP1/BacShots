extends Node2D

var zombie_count = 0
var round = 1
var boss_spawned = false
var soap_boss_packed = preload("res://boss_mobs/Soap/Boss_Soap.tscn")
var blob_boss_packed = preload("res://boss_mobs/Blob/boss_blob.tscn")
var sponge_boss_packed = preload("res://boss_mobs/Sponge/boss_sponge.tscn")
var sprei_boss_packed = preload("res://boss_mobs/Sprei/boss_sprei.tscn")

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

func spawn_blob_boss():
	var blob_boss = blob_boss_packed.instantiate()
	%PathFollow2D.progress_ratio = randf()
	blob_boss.global_position = %PathFollow2D.global_position
	add_child(blob_boss)
	Global.boss_alive4 = true

func spawn_soap_boss():
	var soap_boss = soap_boss_packed.instantiate()
	%PathFollow2D.progress_ratio = randf()
	soap_boss.global_position = %PathFollow2D.global_position
	add_child(soap_boss)
	Global.boss_alive4 = true

func spawn_sprei_boss():
	var sprei_boss = sprei_boss_packed.instantiate()
	%PathFollow2D.progress_ratio = randf()
	sprei_boss.global_position = %PathFollow2D.global_position
	add_child(sprei_boss)
	Global.boss_alive4 = true

func spawn_sponge_boss():
	var sponge_boss = sponge_boss_packed.instantiate()
	%PathFollow2D.progress_ratio = randf()
	sponge_boss.global_position = %PathFollow2D.global_position
	add_child(sponge_boss)
	Global.boss_alive4 = true

func _on_wave_timer_timeout():
	print("Wave ", round, " starting!")
	print(Global.boss_name)
	if round % 5 == 0 and not boss_spawned:
		Global.boss_hp *= Global.boss_num
		Global.boss_speed += 25 * Global.boss_num
		if Global.boss_num == 1:
			spawn_blob_boss()
			Global.boss_name = "Blob"
			var song : AudioStream = load("res://audio_video/1_boss_theme.mp3")
			$AudioStreamPlayer.set_stream(song)
			$AudioStreamPlayer.play()
		if Global.boss_num == 2:
			spawn_sponge_boss()	
			Global.boss_name = "Sponge"
		if Global.boss_num == 3:
			spawn_sprei_boss()
			Global.boss_name = "Sprei"
		if Global.boss_num == 4:
			spawn_soap_boss()
			Global.boss_name = "Soap"
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
