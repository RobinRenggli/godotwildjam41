extends Control

func _ready():
	visible = false
	pause_mode = Node.PAUSE_MODE_PROCESS
	CreatureInfo.connect("evolve_creature", self, "_on_evolve_creature")

func _on_evolve_creature(creature):
	print("received signal")
	visible = true
	Overviewer.pause_game()
