extends Node

var projectile_resource = preload("res://Evolution/Resources/FriendlyProjectile.tscn")

func execute(type):
	var creature = get_parent().get_parent()
	var t = Timer.new()
	t.set_wait_time(0.01)
	self.add_child(t)
	for i in range(creature.Stats.strength):
		var projectile = projectile_resource.instance()
		projectile.global_position = get_parent().get_parent().global_position
		projectile.velocity = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		projectile.type = type
		get_node("/root/Ocean").add_child(projectile)
		AudioController.get_node("BubbleShotSound").play()
		t.start()
		yield(t, "timeout")
	t.queue_free()
