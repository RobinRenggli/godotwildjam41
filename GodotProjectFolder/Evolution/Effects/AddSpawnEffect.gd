extends Node

export (Resource) var effect
var spawner

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	var e = effect.instance()
	spawner.add_child(e)
	spawner.effects_per_creature[type].append(e)
