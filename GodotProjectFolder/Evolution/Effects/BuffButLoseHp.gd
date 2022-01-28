extends Node

export (Resource) var effect

func execute(type):
	for creature in get_tree().get_nodes_in_group("Creatures"):
		if creature.type == type:
			creature.Stats.change_max_health(15)
			creature.Stats.change_health(15)
			creature.Stats.change_strength(3)
			creature.get_node("TimedEffects").add_child(effect.instance())

