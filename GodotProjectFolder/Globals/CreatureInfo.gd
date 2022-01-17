extends Node

export var xp_increase_per_lvl = 5
signal evolve_creature(creature)
var creature_map
var stats_map
var xp_map
var needed_xp_map

func _ready():
	reset()

func reset():
	creature_map = {
	"basic": preload("res://Creatures/BasicCreature.tscn") 
	}
	stats_map = {
		"basic": {
			"cost": 1,
			"health": 4,
			"strength": 1,
			"speed": 3,
			"movepattern": "basic"
		}
	}
	xp_map = {
		"basic": 0
	}
	needed_xp_map = {
		"basic": 5
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