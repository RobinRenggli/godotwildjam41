extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn") 
}
var multiplier_map = {
	"basic": 3
}

var wave_number = 0
export (Array, Dictionary) var waves
var Random = RandomNumberGenerator.new()

func spawn_wave():
	var index = Random.randi_range(0, min(wave_number, waves.size() - 1)) # 0
	var wave = waves[index] 
	for key in wave.keys():
		for i in range(max(wave[key], floor(wave[key] * multiplier_map[key] * (wave_number - index)))):
			spawn_enemy(key)
	wave_number += 1

func spawn_enemy(enemy):
	var spawned_enemy = enemy_map[enemy].instance()
	spawned_enemy.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_enemy)


func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(0, - Constants.spawn_offset)
	return Vector2(x, y)

func _on_SpawnTimer_timeout():
	spawn_wave()
