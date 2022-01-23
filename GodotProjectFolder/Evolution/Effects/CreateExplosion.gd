extends Node

var explosion_resource = preload("res://Evolution/Resources/Explosion.tscn")

func execute(type):
	var explosion = explosion_resource.instance()
	var creature = get_parent().get_parent()
	explosion.global_position = get_parent().get_parent().global_position
	explosion.type = type
	get_node("/root/Ocean").add_child(explosion)
