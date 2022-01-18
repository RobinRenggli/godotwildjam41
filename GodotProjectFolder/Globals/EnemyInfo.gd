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
		"movepattern": "basic"
	},
	"barrel": {
		"health": 12,
		"strength": 2,
		"speed": 1,
		"movepattern": "basic"
	},
}
var multiplier_map = {
	"basic": 1,
	"barrel": 0.5,
}
