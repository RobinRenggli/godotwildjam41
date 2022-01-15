extends Node

onready var creature = self.get_parent()
onready var directionIndicator = Vector2(Constants.window_width/2, Constants.window_height/2)

var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(1,0)

func move(speed, CreatureSprite):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	if out_of_bounds():
		directionIndicator = Vector2(rand_range(0, Constants.window_width), rand_range(0, Constants.window_height))
		
	velocity = (directionIndicator - creature.global_position).normalized()
	CreatureSprite.rotation = velocity.angle()
	
	var collision = creature.move_and_collide(velocity * speed)
	
	if collision:
		directionIndicator = creature.global_position + collision.normal * 100 
		directionIndicatorVelocity = collision.normal
		
	
func _on_Timer_timeout():
	directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
func out_of_bounds():
	if  (directionIndicator.x > Constants.window_width || directionIndicator.x < 0):
		return true
	if (directionIndicator.y > Constants.window_height || directionIndicator.y < 0):
		return true
	return false
