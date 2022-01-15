extends Node2D

func _ready():
	pass # Replace with function body.

func _on_PickupArea_area_entered(area):
	self.queue_free()
