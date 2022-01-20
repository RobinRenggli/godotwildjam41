extends Node

var projectile_resource = preload("res://Evolution/Resources/FriendlyProjectile.tscn")

func execute(type, velocity):
	yield(get_tree().create_timer(rand_range(0,0.5)),"timeout")
	var projectile = projectile_resource.instance()
	projectile.global_position = get_parent().get_parent().global_position
	projectile.velocity = velocity
	projectile.type = type
	get_node("/root/Ocean").add_child(projectile)
	AudioController.get_node("BubbleShotSound").play()


func _on_Timer_timeout():
	execute(get_parent().get_parent().type, get_parent().get_parent().get_node("Movement").velocity)
