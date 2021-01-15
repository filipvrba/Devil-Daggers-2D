extends Area2D

export var health = 10
export var speed = 100

var _direction = Vector2.ZERO
var _velocity = Vector2.ZERO
var _center_screen: Vector2
var _magnitude = 80

onready var protection_timer = $ProtectionTimer
onready var animation_player = $AnimationPlayer


func _ready() -> void:
	$Crystal.health = health
	_center_screen = get_viewport_rect().size / 2
	_direction = (_center_screen - position).normalized()


func _physics_process(delta: float) -> void:
	var angle = atan2(_direction.y, _direction.x)
	rotation_degrees = rad2deg(angle)
	
	if _center_screen.distance_to(position) - _magnitude < Global.size_area:
		return

	_velocity = _direction * speed * delta
	position += _velocity


func _on_Spider_body_entered(body: Node) -> void:
	Global.is_game_over(body)


func _on_Spider_area_entered(area: Area2D) -> void:
	if area is LightProjectile:
		if protection_timer.is_stopped() and\
				animation_player.current_animation == "idle":
			protection_timer.start()


func _on_ProtectionTimer_timeout() -> void:
	animation_player.play("protection")


func _on_Crystal_takes_damage(damage) -> void:
	health -= damage
	if health < 0:
		animation_player.play("die")









