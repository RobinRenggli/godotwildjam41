extends Node

var velocity = Vector2(1,0)


func move(creature, speed):
	creature.move_and_collide(velocity * speed)

func change_direction():
	velocity.x = rand_range(-1,1)
	velocity.y = rand_range(-1,1)
	velocity = velocity.normalized()


func _on_Timer_timeout():
	velocity.x = rand_range(-1,1)
	velocity.y = rand_range(-1,1)
	velocity = velocity.normalized()
