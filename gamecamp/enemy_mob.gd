extends Sprite2D

var velocity = Vector2()
var hp = 3
var stun = false




func _process(delta):
	look_at(Global.player.global_position)
	
	if Global.player != null and stun == false:
		if Global.gameOff == false:
			velocity = global_position.direction_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
	elif stun == true:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	global_position += velocity * Global.enemySpeed * delta
			
	if hp <= 0:
		if Global.Camera != null:
			Global.points += 10  # 10 points for killing enemy
			#here question mark
			var qChance: int = randi_range(1, 1)
			if qChance == 1:
				var result: int = randi_range(1, 6)
				if result == 1:
					# Speed up
					Global.playerSpeed += 50 
				elif result == 2:
					#Double damage
					dmg *= 2
				elif result == 3:
					#2x fire rate
					Global.reloadSpeed /= 2
				elif result == 4:
					#Disable gun for 10s
					Global.canShoot = false
					# await (10seconds)
					await get_tree().create_timer(10.0).timeout
					Global.canShoot = true
				elif result == 5:
					#Inverted movement for 10s
					pass
				elif result == 6:
					#Enemy speed increased by 50
					Global.enemySpeed += 50
			queue_free()

var dmg: int = 1
func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
	if area.is_in_group("enemy_damager") and stun == false:
		modulate = Color("ff0056")
		velocity = -velocity * 6
		hp -= dmg
		stun = true
		$hit_indicator.start()
		area.get_parent().queue_free()

func _on_hit_indicator_timeout():
	modulate = Color("ffffff")
	stun = false
