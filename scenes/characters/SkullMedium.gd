extends Skull

var positions_path_follow: Array


func _ready() -> void:
	randomize()
	positions_path_follow = get_tree().current_scene.\
			get_node("Arena").path_follow_positions
	_change_path_follow()


func _on_Timer_timeout() -> void:
	_change_path_follow()


func _change_path_follow():
	parent = positions_path_follow[randi() % positions_path_follow.size()]
