extends Node

func execute(type):
	get_parent().get_parent().get_node("Stats").change_health(1)
