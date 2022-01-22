extends Node

var spawner

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	spawner.spawn_baby(type)
