extends Sprite2D

var speed = 75
var velocity = Vector2()
var hp = 3
var blood_particles = preload("res://blood_particles.tscn")

func _process(delta):
	look_at(Global.player.global_position)
	
	if Global.player != null:
		if Global.gameOff == false:
			velocity = global_position.direction_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
			
	if hp <= 0:
		if Global.Camera != null:
			Global.Camera.screen.shake(30, 0.1)
			
			Global.points += 10  # 10 points for killing enemy
			if Global.node_creation.parent != null:
				var blood_paricles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
				blood_particles.instance.rotation = velocity.angle()
			queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_damager"):
		modulate = Color("ff0056")
		velocity = -velocity * 6
		hp -= 1
		area.get_parent().queue_free()
