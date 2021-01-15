extends Node

var _skull = preload("res://scenes/characters/Skull.tscn")
var _skull_medium = preload("res://scenes/characters/SkullMedium.tscn")
var _skull_hard = preload("res://scenes/characters/SkullHard.tscn")
var _enemy_spawner = preload("res://scenes/characters/EnemySpawner.tscn")
var _enemy_spawner_medium = preload("res://scenes/characters/EnemySpawnerMedium.tscn")
var _spider_spawner = preload("res://scenes/characters/Spider.tscn")


func _ready() -> void:
	randomize()


func create_enemy_spawner(position: Vector2):
	var enemy = _enemy_spawner.instance()
	enemy.position = position
	add_child(enemy)


func create_enemy_spawner_medium(position: Vector2):
	var enemy = _enemy_spawner_medium.instance()
	enemy.position = position
	add_child(enemy)


func spawn_skull(position: Vector2):
	var skull_node = _skull.instance()
	var random_position = Vector2(position.x + rand_range(-20, 20),
			position.y + rand_range(-20, 20))
	skull_node.position = random_position
	add_child(skull_node)


func spawn_skull_medium(position: Vector2):
	var skull_medium_node = _skull_medium.instance()
	var random_position = Vector2(position.x + rand_range(-20, 20),
			position.y + rand_range(-20, 20))
	skull_medium_node.position = random_position
	add_child(skull_medium_node)


func spawn_skull_hard(position: Vector2):
	var skull_hard_node = _skull_hard.instance()
	var random_position = Vector2(position.x + rand_range(-20, 20),
			position.y + rand_range(-20, 20))
	skull_hard_node.position = random_position
	add_child(skull_hard_node)


func create_spider(position: Vector2):
	var spider = _spider_spawner.instance()
	spider.position = position
	add_child(spider)
