extends Node

export (Resource) var effect

func execute(type):
	var e = effect.instance()
	WaveEffects.add_child(e)
	WaveEffects.effects_per_creature[type].append(e)
