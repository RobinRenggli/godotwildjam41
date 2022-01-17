extends Node

export (Resource) var effect

func execute(type):
	CreatureInfo.death_effects[type].append(effect)
