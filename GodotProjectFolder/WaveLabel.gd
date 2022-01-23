extends Label

var spawner
func _ready():
	text = "Wave 0"
	spawner = get_node("../../../EnemySpawner")
	spawner.connect("wave_spawned", self, "_on_wave_spawned")

func _on_wave_spawned():
	text = "Wave " + str(Overviewer.wave)
