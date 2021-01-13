extends Area2D
class_name LightProjectile

const SPEED = 1000
const DAMAGE = 1

var parent
var random = 0
var _velocity = Vector2.ZERO
var _direction = Vector2.ZERO

func _ready() -> void:
	randomize()
	position = parent.position
	rotation_degrees = _get_rotation_degrees(parent.get_local_mouse_position())
	
	var mouse_position = parent.get_local_mouse_position()
	_direction = mouse_position.normalized()
	_direction = Vector2(_direction.x + rand_range(-random, random),
			_direction.y + rand_range(-random, random))


func _on_LghtProjectile_area_entered(area: Area2D) -> void:
	# Tested implement global class for `Crystal` node.
	# The function caused loop error, when controling area node is
	# Crystal. I'm this remove previous function.
	# This code is last version. I'm implemented controlling an collision layer.
	if area.collision_layer == 16:  # It is `Crystal` layer in five bit.
		if area.is_free:  # If Crystal is free, will the projectiles not removed
			return
	
	queue_free()


func _physics_process(delta: float) -> void:
	_velocity = _direction * SPEED * delta
	position += _velocity
	remove_behind_screen()


func remove_behind_screen():
	var screen = get_viewport_rect().size
	var magnitude = 10
	
	if position.x < -magnitude:
		queue_free()
	elif position.x > screen.x + magnitude:
		queue_free()
	elif position.y < -magnitude:
		queue_free()
	elif position.y > screen.y + magnitude:
		queue_free()


func _get_rotation_degrees(mouse_position):
	"""
	The projectile have direction impact.
	Must be calculate normal rotate.
	"""
	var rotation = atan2(mouse_position.x, -mouse_position.y)
	return rad2deg(rotation)
