extends Node

export (Resource) var effect

func execute(type):
	CreatureInfo.timed_effects[type].append(effect)
