extends Node

var enemy_map = {
	"basic": preload("res://Enemies/BasicEnemy.tscn"),
	"barrel": preload("res://Enemies/BarrelEnemy.tscn"),
}
var stats_map = {
	"basic": {
		"health": 4,
		"strength": 1,
		"speed": 3,
		"movepattern": "basic"
	},
	"barrel": {
		"health": 10,
		"strength": 2,
		"speed": 1,
		"movepattern": "basic"
	},
}
var multiplier_map = {
	"basic": 2.5,
	"barrel": 0.5,
}
