extends Node

const spawn_height = 32

func spawn_creature(creature):
	var cost = CreatureInfo.stats_map[creature]["cost"]
	
	if PlayerStats.currency >= cost: 
		var spawned_creature = CreatureInfo.creature_map[creature].instance()
		spawned_creature.global_position = get_random_spawn_position()
		get_node("/root/Ocean").add_child(spawned_creature)
		PlayerStats.change_currency(-cost)
		AudioController.get_node("CreatureSpawnSound").play()

# TODO: Silvan: remove once Spawn UI is implemented
func _input(event):
	if Input.is_action_just_pressed("spawn_swordfish"):
		spawn_creature("swordfish")
	if Input.is_action_just_pressed("spawn_turtle"):
		spawn_creature("turtle")


func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(Constants.window_height, Constants.window_height + spawn_height)
	return Vector2(x, y)
	
