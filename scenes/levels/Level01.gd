extends Node2D

const screenplay = [
	{
		"sec": 1,
		"enemies": [{
			"position": "top",
			"enemy": "create_enemy_spawner"
		}]
	},
	{
		"sec": 15,
		"enemies": [{
			"position": "down",
			"enemy": "create_enemy_spawner"
		}]
	},
	{
		"sec": 20,
		"enemies": [{
			"position": "top_r",
			"enemy": "create_enemy_spawner"
		}]
	},
	{
		"sec": 25,
		"enemies": [{
			"position": "down_l",
			"enemy": "create_enemy_spawner"
		}]
	},
	{
		"sec": 40,
		"enemies": [{
			"position": "down",
			"enemy": "create_spider"
		}, {
			"position": "middle_r",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
	{
		# Level Up
		"sec": 50,
		"enemies": [{
			"position": "down_l",
			"enemy": "create_enemy_spawner"
		}, {
			"position": "top",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
	{
		"sec": 65,
		"enemies": [{
			"position": "middle_r",
			"enemy": "create_enemy_spawner"
		}, {
			"position": "top",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
	{
		"sec": 80,
		"enemies": [{
			"position": "top",
			"enemy": "create_enemy_spawner"
		}, {
			"position": "down_l",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
	{
		"sec": 95,
		"enemies": [{
			"position": "top",
			"enemy": "create_enemy_spawner"
		}, {
			"position": "down_l",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
	{
		"sec": 110,
		"enemies": [{
			"position": "top_l",
			"enemy": "create_enemy_spawner_medium"
		}]
	},
]
