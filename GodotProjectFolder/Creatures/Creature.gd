extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement
onready var CollisionTimer = $CollisionTimer
export var type = "name"
var last_collider_type
var last_collider
var death_bubbles = preload("res://LittleBubbles.tscn")

func _ready():
	Stats.connect("no_health", self, "_on_stats_no_health")
	Stats.initialize(CreatureInfo.stats_map[type])
	for effect in CreatureInfo.pickup_effects[type]:
		$PickupEffects.add_child(effect.instance())
	for effect in CreatureInfo.death_effects[type]:
		$DeathEffects.add_child(effect.instance())
	for effect in CreatureInfo.timed_effects[type]:
		$TimedEffects.add_child(effect.instance())
		
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Healing"):
		print("collision_detected")
		if not(collider.healed_creatures.has(self)):
			collider.healed_creatures.append(self)
			Stats.change_health(collider.heal)
			$AnimationPlayer.play("Heal")
	if collider.is_in_group("Currency"):
		for pickupEffect in $PickupEffects.get_children():
			pickupEffect.execute(type)
		PlayerStats.change_currency(1)
		CreatureInfo.increase_experience(type, 1)

	if collider.is_in_group("Enemies"):
		if not(last_collider == collider):
			last_collider = collider
			CollisionTimer.start(0.25)
			last_collider_type = collider.type
			Stats.change_health(-collider.Stats.strength)
			$AnimationPlayer.play("Damage")
	
	if collider.is_in_group("Debris"):
		Stats.change_health(-collider.strength)
		$AnimationPlayer.play("Damage")

func _on_stats_no_health():
	for deathEffect in $DeathEffects.get_children():
		deathEffect.execute(type)
	var bubbles = death_bubbles.instance()
	bubbles.global_position = global_position
	get_node("/root/Ocean").add_child(bubbles)
	bubbles.set_emitting(true)
	Overviewer.check_defeat()
	Overviewer.check_crowded()
	#CreatureInfo.increase_experience(last_collider_type, 1)
	self.queue_free()
	if type == "turtle":
		AudioController.get_node("TurtleDeathSound").play()
	if type == "swordfish":
		AudioController.get_node("SwordfishDeathSound").play()
	if type == "clownfish":
		AudioController.get_node("ClownfishDeathSound").play()

func _on_CollisionTimer_timeout():
	last_collider = null



