extends Node

func execute(type):
	var xp = (CreatureInfo.needed_xp_map[type] - CreatureInfo.xp_increase_per_lvl) / 2
	for key in CreatureInfo.xp_map.keys():
		if key != type:
			CreatureInfo.increase_experience(key, xp)
