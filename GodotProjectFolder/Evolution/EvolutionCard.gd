extends NinePatchRect

export (Dictionary) var stat_changes
export (String) var description

var type
var clicked = false

signal evolution_selected()

func _ready():
	create_description()

func create_description():
	if stat_changes != null:
		if not description.empty():
			if not(stat_changes.keys().has("movepattern")) && stat_changes.keys().size() >= 1:
				description += "\n\n"
			if stat_changes.keys().has("movepattern") && stat_changes.keys().size() >= 2:
				description += "\n\n"
		for key in stat_changes.keys():
			if key != "movepattern":
				if key == "cost":
					description += "Increase " + str(key) + " by " + format_number(stat_changes[key]) + "\n"
				elif stat_changes[key] > 0:
					description += "Gain " + format_number(stat_changes[key]) + " " + str(key) + "\n"
				elif stat_changes[key] < 0:
					description += "Lose " + format_number(stat_changes[key]) + " " + str(key) + "\n"
	$MarginContainer/EvolutionText.text = description

func _on_EvolutionCard_gui_input(event): 
	if not clicked and Input.is_action_pressed("ChooseCard") or (event is InputEventScreenTouch and event.is_pressed()):
		clicked = true
		if stat_changes != null:
			evolve_stats()
		for effect in $Effects.get_children():
			effect.execute(type)
		var t = Timer.new()
		t.set_wait_time(0.1)
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


func _on_EvolutionCard_mouse_entered():
	self_modulate = Color(0.8, 0.8, 0.8)


func _on_EvolutionCard_mouse_exited():
	self_modulate = Color(1, 1, 1)
