extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func check_defeat():
	# we check for <= 1, because check defeat is only called right before the last creature gets deleted
	if get_tree().get_nodes_in_group("Creatures").size() <= 1:
		# TODO: got to game over screen
		get_tree().reload_current_scene()
		CreatureInfo.reset()
		PlayerStats.reset_currency()

func pause_game():
	get_tree().paused = true

func resume_game():
	get_tree().paused = false
