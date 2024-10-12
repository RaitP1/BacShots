extends Node2D

func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


func _on_skip_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
