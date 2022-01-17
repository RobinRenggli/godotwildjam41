extends Node

export (Resource) var effect

func execute(type):
	CreatureInfo.pickup_effects[type].append(effect)
