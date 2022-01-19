extends Node2D

var velocity
export var damage = 1
var type

func _physics_process(delta):
	global_position += (velocity * 8)

func _on_Area2D_area_entered(area):
	queue_free()
