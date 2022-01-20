extends Node

export (Dictionary) var stat_changes

# Called when the node enters the scene tree for the first time.
func execute(type):
	for creature in get_tree().get_nodes_in_group("Creatures"):
		if creature.type == type:
			for key in stat_changes.keys():
				match key:
					"health":
						creature.Stats.change_health(stat_changes[key])
					"strength":
						creature.Stats.change_strength(stat_changes[key])
					"speed":
						creature.Stats.change_speed(stat_changes[key])
					"movepattern":
						creature.Stats.set_movepattern(stat_changes[key])

