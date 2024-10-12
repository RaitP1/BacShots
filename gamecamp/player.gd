extends AnimatedSprite2D

var speed = 300
var velocity = Vector2()
var hp = 3

var bullet = preload("res://bullet.tscn")

var can_shoot = true
var is_dead = false

@onready var anim: AnimatedSprite2D = $"."

@onready var aimSpot = $Aimspot

func _ready():	
	anim.play("idle")
	Global.node_creation_parent = $".."
	Global.player = self
	Global.gameOff = false
	
func _exit_tree():
	Global.player = null
	
func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if Input.is_action_pressed("move_right"):
		anim.play("idle")
	elif Input.is_action_pressed("move_left"):
		anim.play("move_left")
	elif Input.is_action_pressed("move_up"):
		anim.play("move_up")
	elif Input.is_action_pressed("move_down"):
		anim.play("move_down")
	else:
		anim.play("idle")
		
	
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 20, 1152)	
	global_position.y = clamp(global_position.y, 20, 648)
	
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
		if hp == 0:
			is_dead = true
			visible = false
			Global.gameOff = true
			await (get_tree().create_timer(1.0).timeout)
			get_tree().reload_current_scene()


func _on_hit_timer_timeout() -> void:
	modulate = Color("ffffff")
