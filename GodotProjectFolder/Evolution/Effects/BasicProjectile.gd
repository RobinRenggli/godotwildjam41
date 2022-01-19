extends Node

var projectile_resource = preload("res://Evolution/Projectiles/FriendlyProjectile.tscn")

func execute(type, velocity):
	var projectile = projectile_resource.instance()
	projectile.global_position = get_parent().get_parent().global_position
	projectile.velocity = velocity
	projectile.type = type
	get_node("/root/Ocean").add_child(projectile)
	AudioController.get_node("BubbleShotSound").play()
