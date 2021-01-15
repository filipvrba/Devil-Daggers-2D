extends Node

var time: float

onready var size_area = (get_viewport().size / 2).x - 20


func _process(delta: float) -> void:
	time += delta


func is_game_over(node: Node) -> void:
	if node is Player:
		get_tree().call_group("game_over", "game_over")
