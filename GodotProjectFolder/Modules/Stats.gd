extends Node

var max_health 
var health
var strength
var speed
var movepattern

signal no_health

func initialize(stats):
	max_health = (stats["health"])
	set_health(max_health)
	set_strength(stats["strength"])
	set_speed(stats["speed"])
	set_movepattern(stats["movepattern"])
	
func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
	
func change_health(amount):
	health += amount
	if health <= 0:
		emit_signal("no_health")

func change_strength(amount):
	strength = max(0, strength + amount)

func change_speed(amount):
	speed = max(0, speed + amount)

func set_strength(value):
	strength = value

func set_speed(value):
	speed = value

func set_movepattern(value):
	movepattern = value
