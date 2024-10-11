extends Camera2D

var screen_shake_start = false
var shake_intensity = 0

func _ready():
	Global.Camera = self
	
func _exit_tree():
	Global.Camera = null

func _process(_delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	
	if screen_shake_start == true:
		global_position += Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))

func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity + 0.002, intensity * 0.02)
	shake_intensity = intensity
	$screen_shake_timer.wait_time = time
	$screen_shake_timer.start()
	screen_shake_start = true

func _on_screen_shake_timer_timeout():
	screen_shake_start = false
	global_position = Vector2(576, 325)
