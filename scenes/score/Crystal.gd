extends Area2D

signal takes_damage(damage)

const SPEED = 6
const SMOOTH = 10

var is_free = false
var parent: Node2D

var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var _is_stoped = false
var _health = 6


func _physics_process(delta: float) -> void:
	if is_free and parent:
		_direction = parent.position - position
		_set_velocity(delta)
		position += _velocity


func reparent(node: Node2D, parent):
	var glob_position = node.global_position
	var glob_rotation = node.global_rotation
	
	node.get_parent().remove_child(node)
	node.position = glob_position
	node.rotation = glob_rotation
	parent.add_child(node)


func shoot(is_active):
	"""
	Global function of player input.
	Shoot is looped, it be a must controlling boolean variable `is_active`.
	@variable is_active: True means active shooting and False deactivate shoot.
	"""
	_is_stoped = is_active


func double_shoot():
	"""
	Global function of player input.
	Double shoot is called once.
	"""
	# At double shoot dalay crystal 
	var direction_fix = Vector2(clamp(_direction.x, -1, 1),
			clamp(_direction.y, -1, 1))
	var size = get_viewport_rect().size / 2
	_velocity = -(direction_fix * SPEED)
	
	if (_velocity + position).distance_to(size) > Global.size_area - 30:
		_velocity = direction_fix


func _set_velocity(delta):
	# The Crystal stop movement at shoot
	if _is_stoped:
		_velocity = _velocity.move_toward(Vector2.ZERO, SMOOTH * delta)
	else:
		_velocity = _velocity.move_toward(_direction * SPEED * delta,
				SMOOTH * delta)


func _on_Crystal_area_entered(area: Area2D) -> void:
	if area is LightProjectile:
		if not is_free:
			$AnimationPlayer.play("blink")
			_health -= area.DAMAGE
			if _health < 0:
				release()
			
			emit_signal("takes_damage", area.DAMAGE)
			
			if not parent:
				parent = area.parent


func _on_Crystal_body_entered(body: Node) -> void:
	if body is Player:
		if is_free:
			PlayerVariables.crystal_count += 1
			$AnimationPlayer.play("small")
			pass


func release() -> void:
	# The crystal will free and add this node join to level node.
	is_free = true
	
	var new_parent = get_tree().current_scene.get_node("Crystals")
	call_deferred("reparent", self, new_parent)

