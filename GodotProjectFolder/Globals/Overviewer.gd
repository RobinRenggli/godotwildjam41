extends Node

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func check_defeat():
	# we check for <= 1, because check defeat is only called right before the last creature gets deleted
	if get_tree().get_nodes_in_group("Creatures").size() <= 1:
		# TODO: got to game over screen
		get_tree().reload_current_scene()
		PlayerStats.reset_currency()

func _input(event):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused

func pause_game():
	get_tree().paused = true
