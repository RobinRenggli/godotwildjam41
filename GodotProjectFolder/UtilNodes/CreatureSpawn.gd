extends Node

const height = 32

var creature_map = {
	"basic": preload("res://Creatures/Creature.tscn") 
}
var cost_map = {
	"basic": 1
}

func spawn_creature(creature):
	var cost = cost_map.get(creature)
	
	if PlayerStats.currency >= cost: 
		var spawned_creature = creature_map.get(creature).instance()
		spawned_creature.global_position = get_random_spawn_position()
		get_node("/root/Ocean").add_child(spawned_creature)
		PlayerStats.change_currency(-cost)

# TODO: Silvan: remove once Spawn UI is implemented
func _input(event):
	if Input.is_action_just_pressed("spawn"):
		print("pressed")
		spawn_creature("basic")

func get_random_spawn_position():
	var viewport = OS.window_size
	return Vector2(rand_range(0, viewport.x),rand_range(viewport.y, viewport.y + height))
	
