extends Node

var spawner
export var spawns_per_wave = 1

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	for i in range(Overviewer.wave * spawns_per_wave):
		spawner.spawn(type)
