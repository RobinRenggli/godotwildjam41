extends Node

const spawn_height = 32

func spawn_with_cost(creature):
	var cost = CreatureInfo.stats_map[creature]["cost"]
	
	if PlayerStats.currency >= cost:
		PlayerStats.change_currency(-cost)
		spawn(creature)

func spawn(creature):
	var spawned_creature = CreatureInfo.creature_map[creature].instance()
	spawned_creature.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_creature)
	AudioController.get_node("CreatureSpawnSound").play()

func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(Constants.window_height, Constants.window_height + spawn_height)
	return Vector2(x, y)
