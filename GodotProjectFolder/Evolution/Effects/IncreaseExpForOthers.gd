extends Node

export var amount = 1
var types = ["turtle", "swordfish", "clownfish"]

func execute(type):
	for other_type in types:
		if other_type != type:
			CreatureInfo.increase_experience(other_type, 1)
