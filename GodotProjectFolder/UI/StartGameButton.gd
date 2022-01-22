extends TextureButton

var OceanScene = preload("res://Ocean.tscn")

func _on_StartGameButton_pressed():
	Overviewer.wave = 0
	get_tree().change_scene_to(OceanScene)
