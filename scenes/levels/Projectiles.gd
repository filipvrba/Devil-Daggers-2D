# Level node for create an projectiles
extends Node

var light_projectile = preload("res://scenes/projectiles/LightProjectile.tscn")


func create_projectile(parent):
	_create_on_parent(parent)


func create_projectiles(parent):
	for _index in range(8):
		_create_on_parent(parent, 0.1)


func _create_on_parent(parent: Player, random_range = 0):
	var projectile = light_projectile.instance()
	projectile.parent = parent
	projectile.random = random_range
	add_child(projectile)
