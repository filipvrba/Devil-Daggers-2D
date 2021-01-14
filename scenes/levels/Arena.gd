extends Node2D

var _wave = 0

onready var spawner_path_follow = $SpawnerPoints/PathFollow2D
onready var enemies_path_follow = $EnemiesPath/PathFollow2D
onready var path_follow_positions: = []
onready var spawn_timer = $SpawnTimer
onready var _screenplay = get_tree().current_scene.screenplay

func _ready() -> void:
	randomize()
	
	for path_node in get_node("PathPositions").get_children():
		path_follow_positions.append(path_node.get_node("PathFollow2D"))


func _process(delta: float) -> void:
	enemies_path_follow.unit_offset += delta / 6
	
	for position_path_follow in path_follow_positions:
		position_path_follow.unit_offset += delta / 3


func game_over():
	#$AnimationPlayer.play("run_enemies_path")
	spawn_timer.stop()


func _on_Timer_timeout() -> void:
	wave()


func wave() -> void:
	_setting_timer()
	_spaw_enemies()
	_wave += 1


func _setting_timer() -> void:
	var future_wave = _wave + 1
	if future_wave >= _screenplay.size():
		return
	
	spawn_timer.wait_time = abs(Global.time - float(
			_screenplay[future_wave]["sec"]))
	spawn_timer.start()


func _spaw_enemies() -> void:
	if _wave > _screenplay.size():
		return
	
	var scene = _screenplay[_wave]
	
	for enemy in scene["enemies"]:
		spawner_path_follow.unit_offset = _select_position(enemy["position"])
		get_tree().call_group("enemies", enemy["enemy"],
				spawner_path_follow.position)


func _select_position(value_name: String) -> float:
	match value_name:
		"top-l":
			return 0.0
		"top":
			return 0.125
		"top_r":
			return 0.251
		"middle_r":
			return 0.376
		"down_r":
			return 0.5
		"down":
			return 0.625
		"down_l":
			return 0.75
		"middle_l":
			return 0.844
		_:
			return 0.0









