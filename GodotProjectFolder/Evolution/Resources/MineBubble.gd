extends Node2D

var velocity
export var damage = 1
var type
var death_bubbles = preload("res://Evolution/Resources/RedLittleBubbles.tscn")

func _on_Area2D_area_entered(area):
	var bubbles = death_bubbles.instance()
	bubbles.global_position = global_position
	get_node("/root/Ocean").add_child(bubbles)
	bubbles.set_emitting(true)
	queue_free()

func _on_Lifetime_timeout():
	self.queue_free()
