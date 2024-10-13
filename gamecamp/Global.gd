extends Node


var node_creation_parent = null
var player = null
var points = 0
var Camera = null
var highscore = 0
var gameOff = false
var playerSpeed: int = 600
var playerRun: int = 400
var enemySpeed: int = 100
var canShoot: bool = true
var reloadSpeed: float = 0.5
var boss_alive1 = false
var boss_alive2 = false
var boss_alive3 = false
var boss_alive4 = false
var boss_hp = 10
var boss_speed: int = 150
var rounds = 1
var boss_num = 2
var boss_name = ""
var inversion_x = false
var inversion_y = false

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
