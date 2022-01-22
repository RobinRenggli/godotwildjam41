extends TextureButton

var OceanScene = preload("res://Ocean.tscn")

func _on_StartGameButton_pressed():
	Overviewer.wave = 0
	Overviewer.game_playing = true
	get_tree().change_scene_to(OceanScene)
