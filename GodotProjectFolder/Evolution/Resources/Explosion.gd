extends Node2D

var type
export var damage = 3
onready var damaged_creatures = []

func _ready():
	scale = Vector2.ZERO
	$Particles.emitting = true

func _physics_process(delta):
	scale += Vector2(0.15, 0.15)
	
func _on_Timer_timeout():
	self.queue_free()
