extends Node

export var xp_increase_per_lvl = 5
signal evolve_creature()
signal stats_changed()

var stats_map
var xp_map
var needed_xp_map
var pickup_effects
var death_effects
var timed_effects
var creature_map = {
	"clownfish": preload("res://Creatures/Clownfish.tscn"),
	"swordfish": preload("res://Creatures/Swordfish.tscn"),
	"turtle": preload("res://Creatures/Turtle.tscn"),
	}
var texture_map = {
	"clownfish": preload("res://Creatures/Clownfish.png"),
	"swordfish": preload("res://Creatures/SwordFish.png"),
	"turtle": preload("res://Creatures/Turtle.png"),
	}

func _ready():
	reset()

func reset():
	stats_map = {
		"clownfish": {
			"cost": 1,
			"health": 2,
			"strength": 2,
			"speed": 5,
			"movepattern": "basic",
			"cooldown": 5
		},
		"swordfish": {
			"cost": 1,
			"health": 3,
			"strength": 2,
			"speed": 3,
			"movepattern": "basic",
			"cooldown": 5
		},
		"turtle": {
			"cost": 1,
			"health": 6,
			"strength": 1,
			"speed": 2,
			"movepattern": "basic",
			"cooldown": 5
		},
	}
	pickup_effects = {
		"clownfish": [],
		"swordfish": [],
		"turtle": [],
	}
	death_effects = {
		"clownfish": [],
		"swordfish": [],
		"turtle": [],
	}
	timed_effects = {
		"clownfish": [],
		"swordfish": [],
		"turtle": [],
	}
	xp_map = {
		"clownfish": 0,
		"swordfish": 0,
		"turtle": 0,
	}
	needed_xp_map = {
		"clownfish": 5,
		"swordfish": 5,
		"turtle": 5,
	}


func increase_experience(creature, amount):
	var xp = xp_map[creature]
	var needed_xp = needed_xp_map[creature]
	var evolved = false
	xp += amount
	while xp >= needed_xp:
		evolved = true
		xp -= needed_xp
		needed_xp_map[creature] = needed_xp + xp_increase_per_lvl
		needed_xp = needed_xp_map[creature]
		Overviewer.evolutionQueue.append(creature)
	if evolved:
		print("Evolving " + creature)
		emit_signal("evolve_creature")
	xp_map[creature] = xp
	
