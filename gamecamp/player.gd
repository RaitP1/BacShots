extends AnimatedSprite2D

var speed = Global.playerSpeed
var velocity = Vector2()
var hp = 3
var bullet = preload("res://bullet.tscn")
var i = 0

var can_shoot = true
var is_dead = false
var timer_started = false

@onready var anim: AnimatedSprite2D = $"."
@onready var progress_bar: ProgressBar = $ProgressBar

@onready var aimSpot = $Aimspot
@onready var path_follow = %PathFollow2D
@onready var shoot_timer = Timer.new()

func _ready():	
	progress_bar.value = hp
	Global.node_creation_parent = $".."
	Global.player = self
	Global.gameOff = false
	add_child(shoot_timer)
	shoot_timer.connect("timeout", _on_shoot_timer_timeout)

	
func _exit_tree():
	Global.player = null
	
func _process(delta):
	progress_bar.value = hp
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if is_dead == false:
		if Input.is_action_pressed("move_right"):
			anim.play("move_right")
		elif Input.is_action_pressed("move_left"):
			anim.play("move_left")
		elif Input.is_action_pressed("move_up"):
			anim.play("move_up")
		elif Input.is_action_pressed("move_down"):
			anim.play("move_down")
		else:
			anim.play("idle")
		
	
	global_position.x = clamp(global_position.x, 20, 3232)	
	global_position.y = clamp(global_position.y, 20, 1664)
	
	
	if Global.boss_name == "Blob":
		velocity.x = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
	
	if Global.boss_name == "Sponge":
		velocity.x = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
		velocity.y = int(Input.is_action_pressed("move_up")) - int(Input.is_action_pressed("move_down"))
	
	if Global.boss_name == "Soap":
		velocity.x = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
		velocity.y = int(Input.is_action_pressed("move_up")) - int(Input.is_action_pressed("move_down"))
		speed = 300
		if not timer_started:  # Use the boolean flag
			timer_started = true
			can_shoot = false
			$shoot_timer.start()
			print(can_shoot)
		
	velocity = velocity.normalized()
	if is_dead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot == true and is_dead == false:
		Global.instance_node(bullet, aimSpot.global_position, Global.node_creation_parent)
		$Reload.start()
		can_shoot = false
	
func _on_reload_timeout():
	can_shoot = true


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		modulate = Color("ff0056")
		$hit_timer.start()
		hp -= 1
		if hp <= 0:
			is_dead = true
			progress_bar.hide()
			anim.play("death_animation")
			await (get_tree().create_timer(3.0).timeout)
			visible = false
			Global.gameOff = true
			await (get_tree().create_timer(1.0).timeout)
			get_tree().reload_current_scene()
	elif area.is_in_group("Boss"):
		modulate = Color("ff0056")
		$hit_timer.start()
		hp -= 3
		if hp <= 0:
			is_dead = true
			progress_bar.hide()
			anim.play("death_animation")
			await (get_tree().create_timer(3.0).timeout)
			visible = false
			Global.gameOff = true
			await (get_tree().create_timer(1.0).timeout)
			get_tree().reload_current_scene()


func _on_hit_timer_timeout() -> void:
	modulate = Color("ffffff")


func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	print(can_shoot)
