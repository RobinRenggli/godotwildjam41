extends Node

onready var creature = self.get_parent()
onready var CollisionTimer = $CollisionTimer
onready var creatureSprite = creature.get_node("Sprite")
onready var creatureCollisionBox = creature.get_node("CollisionPolygon2D")
onready var creatureHitBox = creature.get_node("Body/CollisionPolygon2D")
onready var directionIndicator = Vector2(rand_range(0, Constants.window_width), Constants.window_height/2)


var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(1,0)
var recent_collision = false

func _ready():
	randomize()

func move(speed):
	var movepattern = creature.get_node("Stats").movepattern
	movement_map(speed, movepattern)
	rotate_sprite()
	rotate_collision_boxes()
	
	var collision = creature.move_and_collide(velocity * speed)
	
	if collision:
		recent_collision = true
		collision_map(collision, movepattern)

func movement_map(speed, movepattern):
	if movepattern == "basic":
		basic_movement(speed)
	if movepattern == "hai_ground":
		hai_ground_movement(speed)
	
func collision_map(collision, movepattern):
	if movepattern == "basic":
		basic_collision(collision)
	if movepattern == "hai_ground":
		hai_ground_collision(collision)

func _on_Timer_timeout():
	directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	
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

func basic_movement(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	
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
	
	velocity = (directionIndicator - creature.global_position).normalized()

func basic_collision(collision):
	directionIndicator = creature.global_position + collision.normal * 100 
	directionIndicatorVelocity = collision.normal
	
func hai_ground_movement(speed):
	if  creature.global_position.x > Constants.window_width:
		if velocity.x > 0:
			velocity *= -1
	if creature.global_position.x < 0:
		if velocity.x < 0:
			velocity.x *= -1
	if creature.global_position.y > Constants.window_height:
		if velocity.y > 0:
			velocity.y *= -1
	if creature.global_position.y < 0:
		if velocity.y < 0:
			velocity.y *= -1
	elif not recent_collision:
		if creature.global_position.y > 64:
			velocity = Vector2(0,-1)
		elif creature.global_position.y < 32:
			velocity = Vector2(0,1)
		else:
			if creature.global_position.x < 64:
				velocity = Vector2(1, 0)
			elif creature.global_position.x > 960:
				velocity = Vector2(-1, 0)
			elif velocity.y != 0:
				velocity = Vector2(1, 0)
			
func hai_ground_collision(collision):
	velocity = collision.normal
	CollisionTimer.start(0.5)

func _on_CollisionTimer_timeout():
	recent_collision = false
