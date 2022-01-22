extends Node

export var amount = 1

func execute(type):
	CreatureInfo.increase_experience(type, amount)
