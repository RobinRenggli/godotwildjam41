extends Node

onready var creature = self.get_parent()
onready var timer = $Timer
onready var creatureSprite = creature.get_node("Sprite")
onready var creatureCollisionBox = creature.get_node("CollisionPolygon2D")
onready var creatureHitBox = creature.get_node("Body/CollisionPolygon2D")
onready var directionIndicator = Vector2(rand_range(0, Constants.window_width), Constants.window_height/2)

var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(1,0)

func _ready():
	randomize()

func move(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	handle_out_of_bounds()
	
	velocity = (directionIndicator - creature.global_position).normalized()
	rotate_sprite()
	rotate_collision_boxes()
	
	var collision = creature.move_and_collide(velocity * speed)
	
	if collision:
		directionIndicator = creature.global_position + collision.normal * 100 
		directionIndicatorVelocity = collision.normal
		
func _on_Timer_timeout():
	directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
func handle_out_of_bounds():
	if  directionIndicator.x > Constants.window_width:
		if directionIndicatorVelocity.x > 0:
			directionIndicatorVelocity.x *= -1
	if directionIndicator.x < 0:
		if directionIndicatorVelocity.x < 0:
			directionIndicatorVelocity.x *= -1
	if directionIndicator.y > Constants.window_height:
		if directionIndicatorVelocity.y > 0:
			directionIndicatorVelocity.y *= -1
	if directionIndicator.y < 0:
		if directionIndicatorVelocity.y < 0:
			directionIndicatorVelocity.y *= -1

func rotate_sprite():
	if velocity.x > 0:
		creatureSprite.set_flip_h(false)
		creatureSprite.rotation = velocity.angle()
	else:
		creatureSprite.set_flip_h(true)
		creatureSprite.rotation = (velocity * -1).angle()
		
func rotate_collision_boxes():
	if velocity.x > 0:
		creatureCollisionBox.scale = Vector2(1,1)
		creatureHitBox.scale = Vector2(1,1)
		creatureCollisionBox.rotation = velocity.angle()
		creatureHitBox.rotation = velocity.angle()
	else:
		creatureCollisionBox.scale = Vector2(-1,1)
		creatureHitBox.scale = Vector2(-1,1)
		creatureCollisionBox.rotation = (velocity * -1).angle()
		creatureHitBox.rotation = (velocity * -1).angle()
