extends Node

var spawner

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	for i in range(5):
		spawner.spawn(type)
