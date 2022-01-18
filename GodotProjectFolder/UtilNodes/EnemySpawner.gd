extends Node

var waves = [
	{
		"basic": 3
	},
	{
		"barrel":1
	}
]
var wave_number = 0
var Random = RandomNumberGenerator.new()
signal wave_spawned

func _ready():
	randomize()

func spawn_wave():
	var t = Timer.new()
	t.set_wait_time(0.02)
	self.add_child(t)
	var index = Random.randi_range(0, min(wave_number, waves.size() - 1))
	var wave = waves[index] 
	for key in wave.keys():
		for i in range(max(wave[key], floor(wave[key] * EnemyInfo.multiplier_map[key] * (wave_number - index)))):
			spawn_enemy(key)
			t.start()
			yield(t, "timeout")
	t.queue_free()
	wave_number += 1
	emit_signal("wave_spawned")

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
