extends NinePatchRect

func _on_PollutionWarning_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		visible = false
		print("mousepress")
		AudioController.get_node("SelectEvolutionSound").play()
		Overviewer.resume_game()


func _on_InfoMessage_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		visible = false
		print("mousepress")
		AudioController.get_node("SelectEvolutionSound").play()
		Overviewer.resume_game()
		if Overviewer.evolutionQueue.size() > 0:
			var t = Timer.new()
			t.set_wait_time(0.25)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			get_node("../CreatureEvolution")._on_evolve_creature()
			Overviewer.show_tutorial = false
