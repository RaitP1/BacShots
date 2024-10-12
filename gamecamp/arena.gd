
extends Node2D

var mob_count = 0
var rounds = 0
func spawn_mob():
	var new_mob = preload("res://enemy_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_enemy_spawner_timer_timeout() -> void:
	rounds += 1
	var i = 0
	if rounds == 1:
		while i < 5:
			i += 1
			spawn_mob()
	if 1 < rounds and rounds < 11:
		while i < (rounds * 4 + 5):
			i += 1
			spawn_mob()
	if rounds > 10:
		while i < (rounds * 4 + 5):
			i += 1
			spawn_mob()
