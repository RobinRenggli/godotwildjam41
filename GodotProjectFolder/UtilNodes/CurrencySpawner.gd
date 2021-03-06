extends Node

var currency = preload("res://Currency/Currency.tscn")

func _ready():
	Overviewer.connect("game_started", self, "_on_game_started")
	randomize()

func _on_game_started():
	$Timer.start()

func _on_Timer_timeout():
	yield(get_tree().create_timer(rand_range(0,1)),"timeout")
	var spawned_currency = currency.instance()
	spawned_currency.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_currency)
	AudioController.get_node("FishySpawnSound").play()

func get_random_spawn_position():
	return Vector2(rand_range(32, Constants.window_width-32),rand_range(32, Constants.window_height-32))
