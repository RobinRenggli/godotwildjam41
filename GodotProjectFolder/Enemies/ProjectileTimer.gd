extends Timer

export(Resource) var Projectile

func _on_ProjectileTimer_timeout():
	var projectile = Projectile.instance()
	projectile.global_position = get_parent().global_position
	var velocity = get_parent().get_node("Movement").velocity
	projectile.velocity = velocity
	projectile.rotation = velocity.angle()
	get_node("/root/Ocean").add_child(projectile)
