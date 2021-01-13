extends Node2D

onready var spawner_path_follow = $SpawnerPoints/PathFollow2D
onready var enemies_path_follow = $EnemiesPath/PathFollow2D
onready var path_follow_positions: = []

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
	$Timer.stop()


func _on_Timer_timeout() -> void:
	create_enemy_spawner()


func create_enemy_spawner() -> void:
	spawner_path_follow.offset = randi()
	get_tree().call_group("enemies", "create_enemy_spawner",
		spawner_path_follow.position)
