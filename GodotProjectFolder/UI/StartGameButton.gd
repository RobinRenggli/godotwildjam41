extends TextureButton

var OceanScene = preload("res://Ocean.tscn")

func _on_StartGameButton_pressed():
	AudioController.get_node("StartGameSound").play()
	Overviewer.wave = 0
	Overviewer.game_playing = true
	Overviewer.display_initial_message()
	get_tree().change_scene_to(OceanScene)
