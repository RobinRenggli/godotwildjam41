extends TextureButton

var start_pos
export var type = "turtle" 
var spawner
var creature_evolution
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = rect_position
	spawner = get_node("../../CreatureSpawner")
	creature_evolution = get_node("../CreatureEvolution")


func update_stats():
	$Cost.text = str(CreatureInfo.stats_map[type]["cost"])
	$Exp.text = str(CreatureInfo.xp_map[type]) + "/" + str(CreatureInfo.needed_xp_map[type])
	$Health.text = str(CreatureInfo.stats_map[type]["health"])
	$Strength.text = str(CreatureInfo.stats_map[type]["strength"])
	$Speed.text = str(CreatureInfo.stats_map[type]["speed"])

func _process(delta):
	update_stats()
	if open and rect_position.y > start_pos.y - 100:
		rect_position.y = max(rect_position.y - 1000 * delta, start_pos.y - 100)
	if not open and rect_position.y < start_pos.y:
		rect_position.y = min(rect_position.y + 1000 * delta, start_pos.y)

func _on_CreatureSpawnUI_mouse_entered():
	open = true

func _on_CreatureSpawnUI_mouse_exited():
	open = false

func _on_CreatureSpawnUI_pressed():
	spawner.spawn_creature(type)
