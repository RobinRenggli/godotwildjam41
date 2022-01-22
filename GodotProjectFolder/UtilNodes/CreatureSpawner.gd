extends Node

const spawn_height = 32
var effects_per_creature = {}

func _ready():
	for type in CreatureInfo.creature_map.keys():
		effects_per_creature[type] = []

func spawn_with_cost(type):
	if Overviewer.crowded:
		return
	var cost = CreatureInfo.stats_map[type]["cost"]
	
	if PlayerStats.currency >= cost:
		PlayerStats.change_currency(-cost)
		spawn(type)

func spawn(type):
	if Overviewer.crowded:
		return
	var spawned_creature = CreatureInfo.creature_map[type].instance()
	spawned_creature.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_creature)
	if type == "turtle":
		AudioController.get_node("TurtleSpawnSound").play()
	if type == "swordfish":
		AudioController.get_node("SwordfishSpawnSound").play()
	if type == "clownfish":
		AudioController.get_node("ClownfishSpawnSound").play()
	for eff in effects_per_creature[type]:
		eff.execute(type)
	Overviewer.check_crowded()

func spawn_baby(type):
	if Overviewer.crowded:
		return
	var spawned_creature = CreatureInfo.creature_map[type].instance()
	spawned_creature.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_creature)
	spawned_creature.Stats.max_health = 1
	spawned_creature.Stats.health = 1
	spawned_creature.Stats.strength = 1
	spawned_creature.scale = Vector2(0.5, 0.5)
	if type == "turtle":
		AudioController.get_node("TurtleSpawnSound").play()
	if type == "swordfish":
		AudioController.get_node("SwordfishSpawnSound").play()
	if type == "clownfish":
		AudioController.get_node("ClownfishSpawnSound").play()
	Overviewer.check_crowded()

func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(Constants.window_height, Constants.window_height + spawn_height)
	return Vector2(x, y)
