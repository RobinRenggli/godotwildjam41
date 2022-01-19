extends Node

var spawner
export var spawns = 1

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	spawner.spawn(type)
