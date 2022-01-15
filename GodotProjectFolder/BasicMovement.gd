extends Node

onready var creature = self.get_parent()
onready var directionIndicator = creature.global_position

var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(1,0)

func move(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	if (out_of_bounds()):
		directionIndicator = Vector2(rand_range(0,1024), rand_range(0,576))
		
	velocity = (directionIndicator - creature.global_position).normalized()
	creature.move_and_collide(velocity * speed)
	
func _on_Timer_timeout():
	directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
func out_of_bounds():
	if (directionIndicator.x > 1024 || directionIndicator.x < 0):
		return true
	if (directionIndicator.y > 576 || directionIndicator.y < 0):
		return true
	return false
