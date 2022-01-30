extends Node

var waves = [
	{
		"basic": 2
	},
	{
		"barrel": 1
	},
	{
		"lunch": 1,
	},
	{
		"bag": 1,
	},
	{
		"tire": 1,
	},
]
var Random = RandomNumberGenerator.new()
var type = "turtle"
var pollution_damage = 1
signal wave_spawned

func _ready():
	Overviewer.connect("game_started", self, "_on_game_started")
	randomize()

func _on_game_started():
	$SpawnTimer.start()

func spawn_wave():
	var t = Timer.new()
	var bossWave = (Overviewer.wave >= 49 and Overviewer.wave % 5 == 4) or Overviewer.wave >= 104
	if bossWave and Overviewer.wave < 100:
		match Overviewer.wave:
			49:
				spawn_enemy("big_basic")
			54:
				spawn_enemy("big_barrel")
			59:
				spawn_enemy("big_lunch")
			64:
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
			69:
				spawn_enemy("big_tire")
			74:
				spawn_enemy("big_basic")
				spawn_enemy("big_basic")
				spawn_enemy("big_basic")
				spawn_enemy("big_basic")
				spawn_enemy("big_basic")
			79:
				spawn_enemy("big_barrel")
				spawn_enemy("big_barrel")
				spawn_enemy("big_barrel")
				spawn_enemy("big_barrel")
				spawn_enemy("big_barrel")
			84:
				spawn_enemy("big_lunch")
				spawn_enemy("big_lunch")
				spawn_enemy("big_lunch")
				spawn_enemy("big_lunch")
				spawn_enemy("big_lunch")
			89:
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
			94:
				spawn_enemy("big_tire")
				spawn_enemy("big_tire")
				spawn_enemy("big_tire")
				spawn_enemy("big_tire")
				spawn_enemy("big_tire")
			99:
				spawn_enemy("big_tire")
				spawn_enemy("big_tire")
				spawn_enemy("big_barrel")
				spawn_enemy("big_barrel")
				spawn_enemy("big_basic")
				spawn_enemy("big_basic")
				spawn_enemy("big_lunch")
				spawn_enemy("big_lunch")
				spawn_enemy("big_bag")
				spawn_enemy("big_bag")
			_: 
				spawn_enemy("big_tire")
				spawn_enemy("big_barrel")
				spawn_enemy("big_basic")
				spawn_enemy("big_lunch")
				spawn_enemy("big_bag")

	else:
		t.set_wait_time(0.02)
		self.add_child(t)
		var index = Random.randi_range(0, min(Overviewer.wave, waves.size() - 1))
		var wave = waves[index] 
		for key in wave.keys():
			for i in range(wave[key] + floor(wave[key] * EnemyInfo.multiplier_map[key] * (Overviewer.wave - index))):
				spawn_enemy(key)
				t.start()
				yield(t, "timeout")
		t.queue_free()
	Overviewer.wave += 1
	if Overviewer.wave >= 47 && (Overviewer.wave + 3)%5 == 0 :
		display_pollution_warning()
	elif Overviewer.wave >= 37 && (Overviewer.wave + 3)%10 == 0 :
		display_pollution_warning()
	if Overviewer.wave > 50 && Overviewer.wave%5 == 0 :
		spawn_gas()
	elif Overviewer.wave >= 40 && Overviewer.wave%10 == 0 :
		spawn_gas()
	if Overviewer.wave == 25:
		display_debrie_warning()
	WaveEffects.execute_effects()
	emit_signal("wave_spawned")
	AudioController.get_node("WaveSpawnSound").play()

func spawn_enemy(enemy):
	var spawned_enemy = EnemyInfo.enemy_map[enemy].instance()
	spawned_enemy.global_position = get_random_spawn_position()
	get_node("/root/Ocean").add_child(spawned_enemy)

func spawn_gas():
	pollution_damage += 2
	$GasTimer.start()
	$WaveDuration.start()
	get_node("/root/Ocean/WasteAnimations").play(type)
	AudioController.get_node("PollutionSound").play()
	
func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(0, - Constants.spawn_offset)
	return Vector2(x, y)

func _on_SpawnTimer_timeout():
	Overviewer.check_defeat()
	spawn_wave()

func _on_GasTimer_timeout():
	if type == "turtle":
		if $WaveDuration.time_left < 20 && $WaveDuration.time_left > 10:
			var creatures = get_tree().get_nodes_in_group("Turtles")
			for c in creatures:
				c.get_node("Stats").change_health(-pollution_damage)
	elif type == "swordfish":
		if $WaveDuration.time_left < 20 && $WaveDuration.time_left > 10:
			var creatures = get_tree().get_nodes_in_group("Swordfish")
			for c in creatures:
				c.get_node("Stats").change_health(-pollution_damage)
	elif type == "clownfish":
		if $WaveDuration.time_left < 20 && $WaveDuration.time_left > 10:
			var creatures = get_tree().get_nodes_in_group("Clownfish")
			for c in creatures:
				c.get_node("Stats").change_health(-pollution_damage)

func _on_WaveDuration_timeout():
	pass
	
func display_pollution_warning():
	AudioController.get_node("WarningSound").play()
	var most_common_type = get_tree().get_nodes_in_group("Turtles")
	type = "turtle"
	if get_tree().get_nodes_in_group("Swordfish").size() > most_common_type.size():
		most_common_type = get_tree().get_nodes_in_group("Swordfish")
		type = "swordfish"
	if get_tree().get_nodes_in_group("Clownfish").size() > most_common_type.size():
		most_common_type = get_tree().get_nodes_in_group("Clownfish")
		type = "clownfish"
	get_node("../UiElements/PollutionWarning/MarginContainer/Label").text = "WARNING!!! \n A ship just spilled waste that is very toxic to " + type + ". Within 3 waves, the pollution will arrive..."
	if type == "turtle":
			get_node("../UiElements/PollutionWarning/MarginContainer/Label").text = "WARNING!!! \n A ship just spilled waste that is very toxic to " + type + "s. Within 3 waves, the pollution will arrive..."
	get_node("../UiElements/PollutionWarning").visible = true
	Overviewer.pause_game()

func display_debrie_warning():
	AudioController.get_node("WarningSound").play()
	get_node("../UiElements/PollutionWarning/MarginContainer/Label").text = "WARNING!!! \n Pollution on the planet has gotten worse and more garbage ends up in the ocean!"
	get_node("../UiElements/PollutionWarning").visible = true
	Overviewer.pause_game()
