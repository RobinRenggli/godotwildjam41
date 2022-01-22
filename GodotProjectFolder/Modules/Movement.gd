extends Node

onready var creature = self.get_parent()
onready var CollisionTimer = $CollisionTimer
onready var creatureSprite = creature.get_node("Sprite")
onready var creatureCollisionBox = creature.get_node("CollisionPolygon2D")
onready var creatureHitBox = creature.get_node("Body/CollisionPolygon2D")
onready var directionIndicator = creature.global_position


var velocity = Vector2(1,0)
var directionIndicatorVelocity = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
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
	elif movepattern == "hai_ground":
		hai_ground_movement(speed)
	elif movepattern == "stay_together":
		stay_together_movement(speed)
	elif movepattern == "harvest":
		harvest_movement(speed)
	elif movepattern == "hunt":
		hunt_movement(speed)
	elif movepattern == "pinball":
		pinball_movement(speed)
	
func collision_map(collision, movepattern):
	if movepattern == "basic":
		basic_collision(collision)
	elif movepattern == "hai_ground":
		hai_ground_collision(collision)
	elif movepattern == "stay_together":
		basic_collision(collision)
	elif movepattern == "harvest":
		hai_ground_collision(collision)
	elif movepattern == "hunt":
		hai_ground_collision(collision)
	elif movepattern == "pinball":
		basic_collision(collision)
		
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
	if not recent_collision:
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

func stay_together_movement(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed * 2
	
	if  directionIndicator.x > Constants.window_width * 2/3:
		if directionIndicatorVelocity.x > 0:
			directionIndicatorVelocity.x *= -1
	if directionIndicator.x < 0 + Constants.window_width/3:
		if directionIndicatorVelocity.x < 0:
			directionIndicatorVelocity.x *= -1
	if directionIndicator.y > Constants.window_height * 2/3:
		if directionIndicatorVelocity.y > 0:
			directionIndicatorVelocity.y *= -1
	if directionIndicator.y < 0 + Constants.window_height/3:
		if directionIndicatorVelocity.y < 0:
			directionIndicatorVelocity.y *= -1
	 
	velocity = (directionIndicator - creature.global_position).normalized()
	
func harvest_movement(speed):
	var currency = get_tree().get_nodes_in_group("Currency")
	if currency.empty():
		basic_movement(speed)
	else:
		var nearest_currency = currency[0]
		for fishy in currency:
			if fishy.global_position.distance_to(creature.global_position) < nearest_currency.global_position.distance_to(creature.global_position):
				nearest_currency = fishy

		velocity = (nearest_currency.global_position - creature.global_position).normalized()
		
func hunt_movement(speed):
	var enemies = get_tree().get_nodes_in_group("Enemies")

	if not recent_collision:
		if enemies.empty():
			basic_movement(speed)
		else:
			var nearest_enemy = enemies[0]
			for enemy in enemies:
				if enemy.global_position.distance_to(creature.global_position) < nearest_enemy.global_position.distance_to(creature.global_position):
					nearest_enemy = enemy

			velocity = (nearest_enemy.global_position - creature.global_position).normalized()
			
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
			
func pinball_movement(speed):
	directionIndicator = directionIndicator + directionIndicatorVelocity * speed
	
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

func _on_CollisionTimer_timeout():
	recent_collision = false

func _on_Timer_timeout():
	if not creature.get_node("Stats").movepattern == "pinball":
		directionIndicatorVelocity = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
