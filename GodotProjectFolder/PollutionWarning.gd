extends NinePatchRect

func _on_PollutionWarning_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		visible = false
		print("mousepress")
		Overviewer.resume_game()
