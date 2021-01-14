extends Node

var time: float

onready var size_area = (get_viewport().size / 2).x - 20


func _process(delta: float) -> void:
	time += delta
