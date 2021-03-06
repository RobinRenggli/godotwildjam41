extends Node

var currency = preload("res://Currency/Currency.tscn")
var sparkles = preload("res://Sparkles.tscn")

func execute(type, velocity):
	var spawn_sparkles = sparkles.instance()
	spawn_sparkles.global_position = get_parent().get_parent().global_position
	get_node("/root/Ocean").add_child(spawn_sparkles)
	var spawned_currency = currency.instance()
	spawned_currency.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_currency)
	AudioController.get_node("FishySpawnSound").play()
		
func get_random_spawn_position():
	return Vector2(rand_range(32, Constants.window_width-32),rand_range(32, Constants.window_height-32))

func _on_Timer_timeout():
	execute(get_parent().get_parent().type, get_parent().get_parent().get_node("Movement").velocity)
