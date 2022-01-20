extends Node

var wave = 0;
var evolutionQueue = []

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func check_defeat():
	# we check for <= 1, because check defeat is only called right before the last creature gets deleted
	if get_tree().get_nodes_in_group("Creatures").size() <= 1:
		# TODO: got to game over screen
		get_tree().reload_current_scene()
		for type in CreatureInfo.creature_map.keys():
			WaveEffects.effects_per_creature[type] = []
		CreatureInfo.reset()
		PlayerStats.reset_currency()
		wave = 0
		AudioController.get_node("DefeatSound").play()

func pause_game():
	get_tree().paused = true

func resume_game():
	get_tree().paused = false
 
