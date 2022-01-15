extends Node2D

func _ready():
	pass # Replace with function body.

func _on_PickupArea_body_entered(body):
	self.queue_free()
