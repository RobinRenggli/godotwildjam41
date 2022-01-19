extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn"),
	"barrel": preload("res://Enemies/BarrelEnemy.tscn"),
}
var stats_map = {
	"basic": {
		"health": 4,
		"strength": 2,
		"speed": 3,
		"movepattern": "basic",
		"cooldown": 5
	},
	"barrel": {
		"health": 12,
		"strength": 2,
		"speed": 1,
		"movepattern": "basic",
		"cooldown": 5
	},
}
var multiplier_map = {
	"basic": 0.4,
	"barrel": 0.5,
}
