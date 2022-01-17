extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement
onready var CollisionTimer = $CollisionTimer
export var type = "name"
var last_collider_type
var last_collider

func _ready():
	Stats.connect("no_health", self, "_on_stats_no_health")
	Stats.initialize(CreatureInfo.stats_map[type])
	for effect in CreatureInfo.pickup_effects[type]:
		$PickupEffects.add_child(effect.instance())
	for effect in CreatureInfo.death_effects[type]:
		$DeathEffects.add_child(effect.instance())
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Currency"):
		for pickupEffect in $PickupEffects.get_children():
			pickupEffect.execute()
		PlayerStats.change_currency(1)
		CreatureInfo.increase_experience(type, 1)

	if collider.is_in_group("Enemies"):
		if not(last_collider == collider):
			last_collider = collider
			CollisionTimer.start(0.25)
			last_collider_type = collider.type
			Stats.change_health(-collider.Stats.strength)

func _on_stats_no_health():
	for pickupEffect in $PickupEffects.get_children():
		pickupEffect.execute()
	Overviewer.check_defeat()
	#CreatureInfo.increase_experience(last_collider_type, 1)
	self.queue_free()

func _on_CollisionTimer_timeout():
	last_collider = null
