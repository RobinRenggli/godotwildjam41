extends Node

var Debris = preload("res://Debris/debris.tscn")
var GameOverScreen = preload("res://GameOver.tscn")
var wave = 0;
var evolutionQueue = []
var crowded = false
var gas = false
var debris_timer

func _ready():
	debris_timer = Timer.new()
	debris_timer.set_wait_time(2)
	debris_timer.set_one_shot(false)
	self.add_child(debris_timer)
	debris_timer.start()
	debris_timer.connect("timeout", self, "_on_debris_timer_timeout")

func check_defeat():
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	# we check for <= 1, because check defeat is only called right before the last creature gets deleted
	if get_tree().get_nodes_in_group("Creatures").size() <= 0:
		get_tree().change_scene_to(GameOverScreen)
		for type in CreatureInfo.creature_map.keys():
			WaveEffects.effects_per_creature[type] = []
		CreatureInfo.reset()
		PlayerStats.reset_currency()
		AudioController.get_node("DefeatSound").play()
		

func check_crowded():
	if get_tree().get_nodes_in_group("Creatures").size() >= 100:
		crowded = true
	else:
		crowded = false

func _on_debris_timer_timeout():
	if wave >= 25:
		spawn_debris()
	if wave >= 30:
		debris_timer.set_wait_time(1)
	if wave >= 35:
		debris_timer.set_wait_time(0.5)

func spawn_debris():
	var debris = Debris.instance()
	get_tree().root.get_node("Ocean").add_child(debris)
	debris.global_position = get_random_spawn_position()
	AudioController.get_node("DebrisSpawnSound").play()

func get_random_spawn_position():
	var x = rand_range(0, Constants.window_width)
	var y = rand_range(0, - Constants.spawn_offset)
	return Vector2(x, y)

func pause_game():
	get_tree().paused = true

func resume_game():
	get_tree().paused = false
