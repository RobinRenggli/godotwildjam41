extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn"),
	"barrel": preload("res://Enemies/BarrelEnemy.tscn"),
	"bag": preload("res://Enemies/BagEnemy.tscn"),
	"lunch": preload("res://Enemies/LunchEnemy.tscn"),
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
	"lunch": {
		"health": 6,
		"strength": 4,
		"speed": 2,
		"movepattern": "harvest",
		"cooldown": 5
	},
	"bag": {
		"health": 2,
		"strength": 15,
		"speed": 3,
		"movepattern": "hunt",
		"cooldown": 5
	},
}
var multiplier_map = {
	"basic": 0.3,
	"barrel": 0.3,
	"bag": 0.4,
	"lunch": 0.3
}
