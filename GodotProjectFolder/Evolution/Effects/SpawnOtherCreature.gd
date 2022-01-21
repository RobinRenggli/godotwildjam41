extends Node

var spawner
var types = ["turtle", "swordfish", "clownfish"]

func _ready():
	spawner = get_node("/root/Ocean/CreatureSpawner")
	
func execute(type):
	var selection = []
	for other_type in types:
		if other_type != type:
			selection.append(other_type)
	spawner.spawn(selection[randi()%2])


func _on_Timer_timeout():
	execute(get_parent().get_parent().type)
