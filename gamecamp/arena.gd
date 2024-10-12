
extends Node2D

var mob_count = 0
var round = 0
func spawn_mob():
	var new_mob = preload("res://enemy_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_enemy_spawner_timer_timeout() -> void:
	round += 1
	var i = 0
	while i < round:
		i += 1
		spawn_mob()
	
	
	
