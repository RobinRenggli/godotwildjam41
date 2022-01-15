extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement

func _ready():
	Stats.connect("no_health", self, "_on_stats_no_health")
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Creatures"):
		Stats.change_health(-collider.Stats.strength)

func _on_stats_no_health():
	self.queue_free()
