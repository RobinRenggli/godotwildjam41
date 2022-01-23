extends Node

var mine_resource = preload("res://Evolution/Resources/MineBubble.tscn")

func execute(type):
	yield(get_tree().create_timer(rand_range(0,0.5)),"timeout")
	var mine = mine_resource.instance()
	mine.global_position = get_parent().get_parent().global_position
	mine.type = type
	get_node("/root/Ocean").add_child(mine)
	AudioController.get_node("BubbleShotSound").play()

func _on_Timer_timeout():
	var creature = get_parent().get_parent()
	execute(creature.type)
