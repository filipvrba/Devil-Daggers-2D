extends Node

var _crystal = preload("res://scenes/score/Crystal.tscn")


func create_crystal(position: Vector2):
	var crystal_node = _crystal.instance()
	crystal_node.position = position
	crystal_node.is_free = true
	crystal_node.parent = get_tree().current_scene.get_node("Player")
	add_child(crystal_node)
