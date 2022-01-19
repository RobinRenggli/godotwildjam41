extends Node

var heal_aura_resource = preload("res://Evolution/Projectiles/FriendlyProjectile.tscn")

func execute(type, velocity):
	var heal_aura = heal_aura_resource.instance()
	heal_aura.global_position = get_parent().get_parent().global_position
	get_node("/root/Ocean").add_child(heal_aura)
