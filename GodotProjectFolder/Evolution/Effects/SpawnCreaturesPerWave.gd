extends Node

var spawner
export var spawns_per_wave = 1

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")

func execute(type):
	for i in range(5):
		yield(get_tree().create_timer(0.02), "timeout")
		spawner.spawn(type)
