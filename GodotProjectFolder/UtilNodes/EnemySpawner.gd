extends Node

var waves = [
	{
		"basic": 2
	},
	{
		"barrel": 1
	},
]

var wave_number = 0

var Random = RandomNumberGenerator.new()

func _ready():
	randomize()

func spawn_wave():
	var index = Random.randi_range(0, min(wave_number, waves.size() - 1)) # 0
	var wave = waves[index] 
	for key in wave.keys():
		for i in range(max(wave[key], floor(wave[key] * EnemyInfo.multiplier_map[key] * (wave_number - index)))):
			spawn_enemy(key)
	wave_number += 1

func spawn_enemy(enemy):
	var spawned_enemy = EnemyInfo.enemy_map[enemy].instance()
	spawned_enemy.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_enemy)


func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(0, - Constants.spawn_offset)
	return Vector2(x, y)

func _on_SpawnTimer_timeout():
	spawn_wave()
