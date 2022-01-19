extends Node2D

var velocity
export var heal = 1
var creature
onready var healed_creatures = []

func _ready():
	scale = Vector2.ZERO

func _physics_process(delta):
	scale += Vector2(0.1, 0.1)
	global_position = creature.global_position
	
func _on_Timer_timeout():
	self.queue_free()
