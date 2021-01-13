extends KinematicBody2D
class_name Player

const SPEED = 100
const ROLL_SPEED = SPEED * 2
const ACCLERATION = 500
const FRICTION = 500

enum {
	ROLL,
	MOVE,
	IDLE
}

var _state = IDLE
var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO

onready var roll_timer = $RollTimer


func game_over():
	queue_free()


func _on_RollTimer_timeout() -> void:
	_state = MOVE


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("move_rolll"):
			if _state == MOVE:
				_state = ROLL
				_set_direction()
				roll_timer.start()


func _physics_process(delta: float) -> void:
	if _direction == Vector2.ZERO:
		_state = IDLE
	else:
		if _state == IDLE:
			_state = MOVE
	
	match _state:
		MOVE:
			_set_direction()
			_velocity = _velocity.move_toward(_direction * SPEED,
					ACCLERATION * delta)
		ROLL:
			_velocity = (_direction * ROLL_SPEED)
		IDLE:
			_set_direction()
			_velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	_velocity = move_and_slide(_velocity)


func _set_direction() -> void:
	_direction.x = Input.get_action_strength("move_right") -\
		Input.get_action_strength("move_left")
	_direction.y = Input.get_action_strength("move_down") -\
			Input.get_action_strength("move_up")
	_direction.normalized()
	
	#_calculate_rotate_direction()


func _calculate_rotate_direction() -> void:
	"""The direction will calculate rotate, so get new direction."""
	var mouse_pos = get_local_mouse_position()
	var pos = atan2(mouse_pos.y, mouse_pos.x)
	_direction = _direction.rotated(pos)

















