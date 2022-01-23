extends Node

func execute(type):
	var strength = CreatureInfo.stats_map[type]["strength"]
	var health = CreatureInfo.stats_map[type]["health"]
	CreatureInfo.stats_map[type]["health"] = 1
	CreatureInfo.stats_map[type]["strength"] += (health-1) / 2
