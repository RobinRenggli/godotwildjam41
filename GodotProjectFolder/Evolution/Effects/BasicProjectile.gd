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
	var creature = get_parent().get_parent()
	var velocity = creature.get_node("Movement").velocity
	if creature.get_node("Stats").speed < 0:
		velocity *= -1
	execute(creature.type, creature.get_node("Movement").velocity)
