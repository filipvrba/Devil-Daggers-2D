extends Node

onready var interval_shooting = $IntervalShooting


func _on_IntervalShooting_timeout() -> void:
	shoot()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Must will defined a interval on spawn projectiles
		# Must be implemented double click on shooting
		if event.doubleclick and event.is_action_pressed("shooting"):
			double_shoot()
			
		if event.is_action_pressed("shooting"):
			var _idle = yield(get_tree(), "idle_frame")
			interval_shooting.start()
			get_tree().call_group("shooting", "shoot", true)
		elif event.is_action_released("shooting"):
			var _idle = yield(get_tree(), "idle_frame")
			interval_shooting.stop()
			get_tree().call_group("shooting", "shoot", false)


func shoot():
	get_tree().call_group("projectiles", "create_projectile", get_parent())


func double_shoot():
	get_tree().call_group("projectiles", "create_projectiles", get_parent())
	get_tree().call_group("shooting", "double_shoot")
	get_parent().get_node("AnimationPlayer").play("double_shoot")
