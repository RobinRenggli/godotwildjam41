extends Node

func execute(type):
	var sum = 0
	for creature in get_tree().get_nodes_in_group("Creatures"):
		if creature.type == type:
			creature.queue_free()
			sum += 5
	CreatureInfo.increase_experience(type, sum)
