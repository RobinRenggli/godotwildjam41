extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn"),
	"barrel": preload("res://Enemies/BarrelEnemy.tscn"),
	"bag": preload("res://Enemies/BagEnemy.tscn"),
	"lunch": preload("res://Enemies/LunchEnemy.tscn"),
	"tire": preload("res://Enemies/TireEnemy.tscn"),
	"big_basic": preload("res://Enemies/BigBasicEnemy.tscn"),
	"big_barrel": preload("res://Enemies/BigBarrelEnemy.tscn"),
	"big_bag": preload("res://Enemies/BigBagEnemy.tscn"),
	"big_lunch": preload("res://Enemies/BigLunchEnemy.tscn"),
	"big_tire": preload("res://Enemies/BigTireEnemy.tscn"),
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
		"health": 2000,
		"strength": 30,
		"speed": 3,
		"movepattern": "basic",
		"cooldown": 5
	},
	"big_barrel": {
		"health": 6000,
		"strength": 30,
		"speed": 2,
		"movepattern": "basic",
		"cooldown": 5
	},
	"big_bag": {
		"health": 2500,
		"strength": 1000,
		"speed": 5,
		"movepattern": "hunt",
		"cooldown": 5
	},
	"big_lunch": {
		"health": 5000,
		"strength": 25,
		"speed": 2,
		"movepattern": "harvest",
		"cooldown": 5
	},
	"big_tire": {
		"health": 50000,
		"strength": 100,
		"speed": 2,
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
