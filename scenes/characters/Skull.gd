extends KinematicBody2D
class_name Skull

export var speed = 200
export var health = 1
export var is_dropping_crystal = false

var parent: Node2D
var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var _path_follow: Node2D
var _is_slow = false


func _ready() -> void:
	parent = get_tree().current_scene.get_node_or_null("Player")
	_path_follow = get_tree().current_scene.get_node(
			"Arena/EnemiesPath/PathFollow2D")
	
	if not parent:
		parent = _path_follow


func _physics_process(_delta: float) -> void:
	if not parent:
		parent = _path_follow
	
	_direction = parent.position - position
	_direction = _direction.normalized()
	
	if _is_slow:
		_velocity = _direction * (speed / 2)
		if $SlowSpeed.is_stopped():
			$SlowSpeed.start()
	else:
		_velocity = _direction * speed
	_velocity = move_and_slide(_velocity)


func _on_SlowSpeed_timeout() -> void:
	_is_slow = false


func _on_Area2D_body_entered(body: Node) -> void:
	Global.is_game_over(body)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is LightProjectile:
		health -= area.DAMAGE
		if health <= 0:
			$AnimationPlayer.play("die")
			dropping_crystal()
		else:
			$AnimationPlayer.play("blink")
			_is_slow = true


func dropping_crystal():
	if is_dropping_crystal:
		get_tree().call_group("crystals", "create_crystal", global_position)
