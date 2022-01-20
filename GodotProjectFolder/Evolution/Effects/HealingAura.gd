extends Node

var heal_aura_resource = preload("res://Evolution/Resources/HealAura.tscn")

func execute(type, velocity):
	yield(get_tree().create_timer(rand_range(0,0.5)),"timeout")
	var heal_aura = heal_aura_resource.instance()
	var creature = get_parent().get_parent()
	creature.add_child(heal_aura)

func _on_Timer_timeout():
	execute(get_parent().get_parent().type, get_parent().get_parent().get_node("Movement").velocity)
