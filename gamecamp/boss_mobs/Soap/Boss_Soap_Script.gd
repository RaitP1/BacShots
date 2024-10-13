extends AnimatedSprite2D

@onready var boss_blob: AnimatedSprite2D = $"."

var speed = Global.boss_speed
var velocity = Vector2()
var hp = Global.boss_hp
var stun = false
var dashing = false

func _process(delta):
#	look_at(Global.player.global_position)
	if Global.player != null and stun == false:
		if Global.gameOff == false:
			boss_blob.play("movement")
			velocity = global_position.direction_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
	elif stun == true:
    if global_position.distance_to(Global.player.global_position) < 100:
        start_dash()
    if dashing:
        velocity = velocity.normalized() * 500  # Increase the speed for dash
        if global_position.distance_to(Global.player.global_position) > 200:  # End dash when far enough
            dashing = false
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	global_position += velocity * speed * delta
	if hp <= 0 and Global.Camera != null:
		Global.Camera.screen_shake(30, 0.1)
		Global.points += 10  # 10 points for killing enemy
		Global.boss_alive4 = false
		Global.rounds += 1
		Global.boss_num += 1
		Global.boss_name = ""
		Global.hp = 10
		Global.speed = 150
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

func start_dash():
    dashing = true
