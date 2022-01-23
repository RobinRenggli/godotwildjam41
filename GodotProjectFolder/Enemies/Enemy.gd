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
	Stats.initialize(EnemyInfo.stats_map[type])
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Explosions"):
		if not(collider.damaged_creatures.has(self)):
			last_collider_type = collider.type
			collider.damaged_creatures.append(self)
			Stats.change_health(-collider.damage)
	if collider.is_in_group("Projectiles"):
		last_collider_type = collider.type
		Stats.change_health(-collider.damage)
		AudioController.get_node("BubblePopSound").play()
	if collider.is_in_group("Creatures"):
		if not(last_collider == collider):
			last_collider = collider
			CollisionTimer.start(0.25)
			last_collider_type = collider.type
			AudioController.get_node("CollisionSound").play()
	if collider.is_in_group("Currency"):
		AudioController.get_node("FishyStealSound").play()

func _on_stats_no_health():
	Overviewer.check_defeat()
	CreatureInfo.increase_experience(last_collider_type, 1)
	var bubbles = death_bubbles.instance()
	bubbles.global_position = global_position
	get_node("/root/Ocean").add_child(bubbles)
	bubbles.set_emitting(true)
	self.queue_free()
	if type == "basic":
		AudioController.get_node("SmallEnemyDeathSound").play()
	if type == "barrel":
		AudioController.get_node("BigEnemyDeathSound").play()


func _on_CollisionTimer_timeout():
	last_collider = null
	
func take_damage(amount, type):
	last_collider_type = type
	Stats.change_health(-amount)
