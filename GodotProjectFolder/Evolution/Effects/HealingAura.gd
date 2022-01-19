extends Node

var heal_aura_resource = preload("res://Evolution/Resources/HealAura.tscn")

func execute(type, velocity):
	var heal_aura = heal_aura_resource.instance()
	var creature = get_parent().get_parent()
	heal_aura.creature = creature
	get_node("/root/Ocean").add_child(heal_aura)
