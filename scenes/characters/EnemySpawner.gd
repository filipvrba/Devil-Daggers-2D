extends KinematicBody2D

const SPEED = 0.01
const MAX_SPEED = 0.2
const MIDDLE_RADIUS = 10
const SMOOTH = 5

export var health = 6
export var spawn_skull_type = "medium"

var is_move = true

var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var _center_screen = Vector2.ZERO
var _speed = 0

onready var spawn_timer = $SpawnTimer


func _ready() -> void:
	_center_screen = get_viewport_rect().size / 2
	_direction = _center_screen - position


func _physics_process(delta: float) -> void:
	if _center_screen.distance_to(position) < Global.size_area:
		if _speed != SPEED:
			_speed = SPEED
			spawn_timer.start()
			_spawn_enemies()
	else:
		_speed = MAX_SPEED
	
	_velocity = _velocity.move_toward(_direction * _speed, SMOOTH)
	
	if _center_screen.distance_to(position) > MIDDLE_RADIUS:
		move_and_slide(_velocity)


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		get_tree().call_group("game_over", "game_over")


func game_over():
	spawn_timer.stop()


func _on_Crystal_takes_damage(damage) -> void:
	health -= damage
	if health < 0:
		# The enemy spawner disappear, therefore will start animation for die.
		$AnimationPlayer.play("die")


func _on_SpawnTimer_timeout() -> void:
	get_tree().call_group("enemies", "spawn_skull_" + spawn_skull_type,
			global_position)
	for _index in range(4):
		yield(get_tree().create_timer(0.2), "timeout")
		get_tree().call_group("enemies", "spawn_skull", global_position)


func _spawn_enemies():
	yield(get_tree().create_timer(1), "timeout")
	_on_SpawnTimer_timeout()
