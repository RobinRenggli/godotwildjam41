extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	Movement.move(self, Stats.speed * delta * Constants.delta_factor)
