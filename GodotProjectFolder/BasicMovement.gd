extends Node

onready var creature = self.get_parent()
onready var timer = $Timer
onready var creatureSprite = creature.get_node("Sprite")
onready var directionIndicator = Vector2(Constants.window_width/2, Constants.window_height/2)

var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(1,0)

func move(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	handle_out_of_bounds()
	
	velocity = (directionIndicator - creature.global_position).normalized()
	rotate_sprite()
	
	var collision = creature.move_and_collide(velocity * speed)
	
	if collision:
		directionIndicator = creature.global_position + collision.normal * 100 
		directionIndicatorVelocity = collision.normal
		
func _on_Timer_timeout():
	directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
func handle_out_of_bounds():
	if  directionIndicator.x > Constants.window_width || directionIndicator.x < 0:
		directionIndicatorVelocity.x *= -1
		timer.start()
	if directionIndicator.y > Constants.window_height || directionIndicator.y < 0:
		directionIndicatorVelocity.y *= -1
		timer.start()
	
func rotate_sprite():
	if velocity.x > 0:
		creatureSprite.set_flip_h(false)
		creatureSprite.rotation = velocity.angle()
	else:
		creatureSprite.set_flip_h(true)
		creatureSprite.rotation = (velocity * -1).angle()
