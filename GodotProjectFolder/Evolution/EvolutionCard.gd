extends PanelContainer

export (Dictionary) var stat_changes
export (String) var description 
var creature

signal evolution_selected()

func _ready():
	create_description()

func create_description():
	
	if stat_changes != null:
		for key in stat_changes.keys():
			description += str(key) + ": " + format_number(stat_changes[key]) + "\n"
	$MarginContainer/EvolutionText.text = description

func _on_EvolutionCard_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if stat_changes != null:
			evolve_stats()
		emit_signal("evolution_selected")

func evolve_stats():
	for key in stat_changes.keys():
		CreatureInfo.stats_map[creature][key] += stat_changes[key]

func format_number(number):
	if (number >= 0):
		return "+" + str(number)
	else:
		return "-" + str(number)
	
