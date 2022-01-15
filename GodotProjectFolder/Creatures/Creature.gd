extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement
onready var CreatureSprite = $Sprite

func _ready():
	Stats.connect("no_health", self, "_on_stats_no_health")
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor, CreatureSprite)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Currency"):
		PlayerStats.change_currency(1)

	if collider.is_in_group("Enemies"):
		Stats.change_health(-collider.Stats.strength)

func _on_stats_no_health():
	self.queue_free()
