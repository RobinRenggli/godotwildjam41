extends Node

export var xp_increase_per_lvl = 5
signal evolve_creature(creature)

var creature_map = {
	"basic": preload("res://Creatures/BasicCreature.tscn") 
}
var cost_map = {
	"basic": 1
}
var xp_map = {
	"basic": 0
}
var needed_xp_map = {
	"basic": 5
}

func increase_experience(creature, amount):
	var xp = xp_map[creature]
	print(creature + "gained experience")
	var needed_xp = needed_xp_map[creature]
	xp += amount
	if xp >= needed_xp:
		print("evolving")
		xp -= needed_xp
		needed_xp_map[creature] = needed_xp + xp_increase_per_lvl
		emit_signal("evolve_creature", creature)
	xp_map[creature] = xp
