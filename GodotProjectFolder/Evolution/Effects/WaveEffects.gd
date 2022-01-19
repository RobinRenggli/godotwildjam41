extends Node

var effects_per_creature = {}

func _ready():
	for type in CreatureInfo.creature_map.keys():
		effects_per_creature[type] = []

func execute_effects():
	for type in effects_per_creature.keys():
		for eff in effects_per_creature[type]:
			eff.execute(type)
