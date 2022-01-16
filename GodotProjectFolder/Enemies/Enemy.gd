extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement
export var type = "name"
var last_collider

func _ready():
	Stats.connect("no_health", self, "_on_stats_no_health")
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor)

func _on_Body_area_entered(area):
	var collider = area.get_parent()
	if collider.is_in_group("Creatures"):
		last_collider = collider  
		Stats.change_health(-collider.Stats.strength)

func _on_stats_no_health():
	Overviewer.check_defeat()
	CreatureInfo.increase_experience(last_collider.type, 1)
	get_node("/root/Ocean").remove_child(self)
