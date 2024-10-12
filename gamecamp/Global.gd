extends Node


var node_creation_parent = null
var player = null
var points = 0
var Camera = null
var highscore = 0
var gameOff = false
var playerSpeed: int = 500
var enemySpeed: int = 200
var canShoot: bool = true
var reloadSpeed: float = 0.5
var boss_alive1 = false
var boss_alive2 = false
var boss_alive3 = false
var boss_alive4 = false
var rounds = 0

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
