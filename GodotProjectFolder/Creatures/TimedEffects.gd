extends Node

var projectile_resource = preload("res://FriendlyProjectile.tscn")

func _on_Timer_timeout():
	for TimedEffect in get_children():
		if not(TimedEffect.get_name() == "Timer"):
			TimedEffect.execute(get_parent().type, get_parent().get_node("Movement").velocity)
