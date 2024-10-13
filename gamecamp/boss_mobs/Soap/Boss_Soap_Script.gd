extends AnimatedSprite2D

@onready var boss_blob: AnimatedSprite2D = $"."
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var boss_sprei: AnimatedSprite2D = $"."
@onready var boss_soap: AnimatedSprite2D = $"."
@onready var boss_sponge: AnimatedSprite2D = $"."

var speed = Global.boss_speed
var velocity = Vector2()
var hp = Global.boss_hp
var stun = false
var dashing = false

func _process(delta):
	if Global.player != null and stun == false:
		if Global.gameOff == false:
			if Global.boss_name == "Blob":
				boss_blob.play("movement")
				velocity = global_position.direction_to(Global.player.global_position)
				
			elif Global.boss_name == "Sponge":
				boss_sponge.play("movement")
				velocity = global_position.direction_to(Global.player.global_position)
			
			elif Global.boss_name == "Sprei":
				boss_sprei.play("movement")
				velocity = global_position.direction_to(Global.player.global_position)
			elif Global.boss_name == "Soap":
				boss_soap.play("movement")
				velocity = global_position.direction_to(Global.player.global_position)
		else:
			velocity = Vector2(0, 0)
	global_position += velocity * speed * delta
	if global_position.distance_to(Global.player.global_position) < 100:
		start_dash()
	if dashing:
		velocity = velocity.normalized() * 500  # Increase the speed for dash
		if global_position.distance_to(Global.player.global_position) > 200:  # End dash when far enough
			dashing = false
	if hp <= 0 and Global.Camera != null:
		Global.Camera.screen_shake(30, 0.1)
		Global.points += 10000  # 10 points for killing enemy
		Global.boss_alive4 = false
		Global.rounds += 1
		Global.boss_num += 1
		Global.boss_name = ""
		Global.boss_hp = 10
		Global.boss_speed = 150
		Global.Camera.screen_shake(0, 0)
		queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		hp -= 1
	if area.is_in_group("enemy_damager") and stun == false:
		modulate = Color("ff0056")
		hp -= 1
		stun = true
		$"hit_timer".start()
		area.get_parent().queue_free()

func _on_hit_timer_timeout() -> void:
	modulate = Color("ffffff")
	stun = false

func start_dash():
	dashing = true
