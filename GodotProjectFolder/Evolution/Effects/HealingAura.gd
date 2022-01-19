extends Node

var heal_aura_resource = preload("res://Evolution/Resources/HealAura.tscn")

func execute(type, velocity):
	var heal_aura = heal_aura_resource.instance()
	var creature = get_parent().get_parent()
	creature.add_child(heal_aura)
