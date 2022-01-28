extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn"),
	"barrel": preload("res://Enemies/BarrelEnemy.tscn"),
	"bag": preload("res://Enemies/BagEnemy.tscn"),
	"lunch": preload("res://Enemies/LunchEnemy.tscn"),
	"tire": preload("res://Enemies/TireEnemy.tscn"),
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
	"bag": {
		"health": 2,
		"strength": 15,
		"speed": 3,
		"movepattern": "hunt",
		"cooldown": 5
	},
	"lunch": {
		"health": 6,
		"strength": 1,
		"speed": 2,
		"movepattern": "harvest",
		"cooldown": 5
	},
	"tire": {
		"health": 25,
		"strength": 2,
		"speed": 1,
		"movepattern": "stay_together",
		"cooldown": 5
	},
	"big_basic": {
		"health": 40,
		"strength": 5,
		"speed": 3,
		"movepattern": "basic",
		"cooldown": 5
	},
	"big_barrel": {
		"health": 120,
		"strength": 5,
		"speed": 1,
		"movepattern": "basic",
		"cooldown": 5
	},
	"big_bag": {
		"health": 50,
		"strength": 1000,
		"speed": 4,
		"movepattern": "hunt",
		"cooldown": 5
	},
	"big_lunch": {
		"health": 60,
		"strength": 5,
		"speed": 2,
		"movepattern": "harvest",
		"cooldown": 5
	},
	"big_tire": {
		"health": 1000,
		"strength": 5,
		"speed": 1,
		"movepattern": "stay_together",
		"cooldown": 5
	},
}
var multiplier_map = {
	"basic": 0.6,
	"barrel": 0.35,
	"bag": 0.5,
	"lunch": 0.5,
	"tire": 0.3
}
