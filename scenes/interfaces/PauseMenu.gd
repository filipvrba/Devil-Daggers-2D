extends Control


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			get_tree().paused = !get_tree().paused
