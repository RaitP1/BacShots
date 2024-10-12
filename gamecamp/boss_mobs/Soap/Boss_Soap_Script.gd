extends AnimatedSprite2D

var speed = 75
var velocity = Vector2()
var hp = 5
var stun = false

func _process(delta):
	look_at(Global.player.global_position)
	if Global.player != null and stun == false:
		if Global.gameOff == false:
			velocity = global_position.direct ion_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
	elif stun == true:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	global_position += velocity * speed * delta
	if hp <= 0 and Global.Camera != null:
		Global.Camera.screen_shake(30, 0.1)
		Global.points += 10  # 10 points for killing enemy
		Global.boss_alive4 = false
		Global.rounds += 1
		queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
	if area.is_in_group("enemy_damager") and stun == false:
		modulate = Color("ff0056")
		velocity = -velocity * 6
		hp -= 1
		stun = true
		$"hit_timer".start()
		area.get_parent().queue_free()

func _on_hit_timer_timeout() -> void:
	modulate = Color("ffffff")
	stun = false
