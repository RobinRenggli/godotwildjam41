extends Node

func _on_Timer_timeout():
	get_parent().get_parent().get_node("Stats").change_strength(-1)
