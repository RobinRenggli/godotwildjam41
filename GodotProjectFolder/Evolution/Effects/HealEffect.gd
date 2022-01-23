extends Node

func execute(type):
	if get_parent().get_parent().get_node("Stats").health > 0:
		get_parent().get_parent().get_node("Stats").change_health(1)
