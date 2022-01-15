extends Node

var velocity = Vector2(1,0)


func move(creature, speed):
	creature.move_and_collide(velocity * speed)

