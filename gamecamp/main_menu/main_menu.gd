extends Node2D
@onready var asmr: AudioStreamPlayer = $Asmr

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://arena.tscn")

func _on_asmr_pressed() -> void:
	asmr.play()
