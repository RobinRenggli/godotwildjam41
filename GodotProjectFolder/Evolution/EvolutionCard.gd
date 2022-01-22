extends NinePatchRect

export (Dictionary) var stat_changes
export (String) var description
var type

signal evolution_selected()

func _ready():
	create_description()

func create_description():
	if stat_changes != null:
		if not description.empty():
			description += "\n\n"
		for key in stat_changes.keys():
			if key != "movepattern":
				if stat_changes[key] > 0:
					description += "Gain " + format_number(stat_changes[key]) + " " + str(key) + ".\n"
				elif stat_changes[key] < 0:
					description += "Lose " + format_number(stat_changes[key]) + " " + str(key) + ".\n"
	$MarginContainer/EvolutionText.text = description

func _on_EvolutionCard_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if stat_changes != null:
			evolve_stats()
		for effect in $Effects.get_children():
			effect.execute(type)
		var t = Timer.new()
		t.set_wait_time(0.001)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		emit_signal("evolution_selected")

func evolve_stats():
	for key in stat_changes.keys():
		if typeof(stat_changes[key]) == TYPE_STRING:
			CreatureInfo.stats_map[type][key] = stat_changes[key]
		elif typeof(stat_changes[key]) == TYPE_INT:
			var initial_value = CreatureInfo.stats_map[type][key]
			var new_value = initial_value + stat_changes[key]
			if key == "speed" || key == "health":
				new_value = clamp(new_value, 1, new_value)
			else:
				new_value = clamp(new_value, 0, new_value)
			CreatureInfo.stats_map[type][key] = new_value

func format_number(number):
	if typeof(number) == typeof(1):
		if (number >= 0):
			return "+" + str(number)
		else:
			return str(number)
	else:
		return number
	


func _on_Container_gui_input(event):
	pass # Replace with function body.
