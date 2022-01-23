extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(Overviewer.wave)


func _on_Timer_timeout():
	if Overviewer.wave <= 10:
		AudioController.get_node("PlanktonRankSound").play()
	elif Overviewer.wave <= 15:
		AudioController.get_node("SeabassRankSound").play()
	elif Overviewer.wave <= 20:
		AudioController.get_node("PiranhaRankSound").play()
	elif Overviewer.wave <= 25:
		AudioController.get_node("TunaRankSound").play()
	elif Overviewer.wave <= 30:
		AudioController.get_node("StingRayRankSound").play()
	elif Overviewer.wave <= 35:
		AudioController.get_node("BlueMarlinRankSound").play()
	elif Overviewer.wave <= 40:
		AudioController.get_node("WhiteSharkRankSound").play()
	elif Overviewer.wave <= 45:
		AudioController.get_node("OrcaRankSound").play()
	elif Overviewer.wave <= 50:
		AudioController.get_node("BlueWhaleRankSound").play()
	elif Overviewer.wave >= 51:
		AudioController.get_node("KrakenRankSound").play()
