extends Node

export var xp_increase_per_lvl = 5
signal evolve_creature(creature)

var stats_map
var xp_map
var needed_xp_map
var pickup_effects
var creature_map = {
	"swordfish": preload("res://Creatures/Swordfish.tscn"),
	"turtle": preload("res://Creatures/Turtle.tscn"),
	}
var texture_map = {
	"swordfish": preload("res://Creatures/SwordFish.png"),
	"turtle": preload("res://Creatures/Turtle.png"),
	}

func _ready():
	reset()

func reset():
	stats_map = {
		"swordfish": {
			"cost": 1,
			"health": 3,
			"strength": 2,
			"speed": 3,
			"movepattern": "basic"
		},
		"turtle": {
			"cost": 1,
			"health": 6,
			"strength": 1,
			"speed": 2,
			"movepattern": "basic"
		},
	}
	pickup_effects = {
		"swordfish": [],
		"turtle": [],
	}
	xp_map = {
		"swordfish": 0,
		"turtle": 0,
	}
	needed_xp_map = {
		"swordfish": 5,
		"turtle": 5,
	}


func increase_experience(creature, amount):
	var xp = xp_map[creature]
	var needed_xp = needed_xp_map[creature]
	xp += amount
	if xp >= needed_xp:
		print("evolving")
		xp -= needed_xp
		needed_xp_map[creature] = needed_xp + xp_increase_per_lvl
		emit_signal("evolve_creature", creature)
	xp_map[creature] = xp
