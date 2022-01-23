extends Node

export (Resource) var effect

func execute(type):
	CreatureInfo.kill_effects[type].append(effect)
