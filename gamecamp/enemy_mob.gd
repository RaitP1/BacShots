extends AnimatedSprite2D

@onready var enemy: AnimatedSprite2D = $"."

var dead = false
var velocity = Vector2()
var hp = 3
var stun = false

func _process(delta):
#	look_at(Global.player.global_position)
	if hp > 0:
		if Global.player != null and stun == false:
			if Global.gameOff == false:
				velocity = global_position.direction_to(Global.player.global_position)
				enemy.play("idle")
			else:
				velocity = Vector2(0, 0)
		elif stun == true:
			velocity = lerp(velocity, Vector2(0, 0), 0.3)
				
		global_position += velocity * Global.enemySpeed * delta
	else:
		if Global.Camera != null:
			
			var result: int = randi_range(1, 7)
			var result2: int = randi_range(1, 100)
			if result2 == 1000 and Global.hp < 3:
				#Health added
				Global.hp += 1
				Global.effectName = "Health++"
				await get_tree().create_timer(5.0).timeout
				Global.effectName = ""
			if result == 1:
				# Speed up
				Global.playerSpeed += 50
				Global.effectName = "Speed++"
				await get_tree().create_timer(5.0).timeout
				Global.effectName = ""
			elif result == 2:
				#Double damage
				dmg *= 5
				Global.effectName = "Damage++"
				await get_tree().create_timer(5.0).timeout
				Global.effectName = ""
			elif result == 3:
				#2x fire rate
				Global.reloadSpeed *= 0.95
				Global.effectName = "Fire rate++"
				await get_tree().create_timer(5.0).timeout
				Global.effectName = ""
			elif result == 4:
				#Disable gun for 10s
				#Global.canShoot = false
				# await (10seconds)
				#Global.effectName = "Gun disabled"
				#await get_tree().create_timer(10.0).timeout
				#Global.canShoot = true
				#Global.effectName = "Gun enabled"
				pass
			elif result == 5:
				#Inverted movement for 10s
				pass
			elif result == 6:
				#Enemy speed increased by 50
				Global.enemySpeed += 6
			elif result == 7:
				#Player speed decreased by 50
				Global.playerSpeed -= 1
			die()

var dmg: int = 1
func _on_hitbox_area_entered(area):
	if not dead:
		if area.is_in_group("player"):
			hp = 0
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
	
func die():
	dead = true
	if Global.Camera != null:
		Global.points += 1
	enemy.play("death_animation")
	await get_tree().create_timer(.8).timeout
	queue_free()
