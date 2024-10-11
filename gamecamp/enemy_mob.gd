extends Sprite2D

var speed = 75
var velocity = Vector2()
var hp = 3

func _process(_delta):
	look_at(Global.player.global_position)
	
	if Global.player != null:
		if Global.gameOff == false:
			velocity = global_position.direction_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
			
	global_position += velocity * speed * _delta
			
	if hp <= 0:
		if Global.Camera != null:
			# Global.Camera.screen_shake(30, 0.1)
			Global.points += 10  # 10 points for killing enemy
			queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy_damager"):
		modulate = Color("ff0056")
		velocity = -velocity * 6
		hp -= 1
		$hit_indicator.start()
		area.get_parent().queue_free()

func _on_hit_indicator_timeout():
	modulate = Color("ffffff")
