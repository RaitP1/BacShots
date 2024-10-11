extends Sprite2D

var speed = 300
var velocity = Vector2()

var bullet = preload("res://bullet.tscn")

var can_shoot = true
var is_dead = false


@onready var aimSpot = $Aimspot

func _ready():
	Global.player = self
	Global.gameOff = false
	
func _exit_tree():
	Global.player = null
	
