extends Node2D

export var strength = 2
var velocity



func _physics_process(delta):
	global_position += (velocity * 8)
	if  global_position.x > Constants.window_width + 100 || global_position.x < -100 || global_position.y > Constants.window_height  + 100  || global_position.y < -100:
		queue_free()
	
func _on_Area2D_area_entered(area):
	queue_free()
