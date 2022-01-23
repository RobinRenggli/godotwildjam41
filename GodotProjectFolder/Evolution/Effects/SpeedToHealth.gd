extends Node

func execute(type):
	var speed = CreatureInfo.stats_map[type]["speed"]
	var health = CreatureInfo.stats_map[type]["health"]
	CreatureInfo.stats_map[type]["speed"] = 1
	CreatureInfo.stats_map[type]["health"] += (speed-1)
