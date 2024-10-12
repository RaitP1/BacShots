extends Sprite2D
extends AnimatedSprite2D

#uses Global.speed instead
#var speed = 600
var velocity = Vector2()
var hp = 3

var bullet = preload("res://bullet.tscn")

#use global script var instead
#var can_shoot = true
var is_dead = false

@onready var my_timer: Node = get_node("Reload")

@onready var aimSpot = $Aimspot
@onready var path_follow = $Path2D/PathFollow2D

func _ready():
	# temporary next line
	my_timer.wait_time = Global.reloadSpeed
	my_timer.start()
	Global.node_creation_parent = $".."
	Global.player = self
	Global.gameOff = false
	
func _exit_tree():
	Global.player = null
	
func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 20, 1152)	
	global_position.y = clamp(global_position.y, 20, 648)
	my_timer.wait_time = Global.reloadSpeed

	if is_dead == false:
		global_position += Global.playerSpeed * velocity * delta

	if Input.is_action_pressed("click") and Global.node_creation_parent != null and Global.canShoot == true and is_dead == false:
		look_at(get_global_mouse_position())
		Global.instance_node(bullet, aimSpot.global_position, Global.node_creation_parent)
		$Reload.start()
		Global.canShoot = false


func _on_reload_timeout():
	Global.canShoot = true
	


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
