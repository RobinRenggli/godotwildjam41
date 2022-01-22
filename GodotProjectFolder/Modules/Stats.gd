extends Node

var max_health 
var health
var strength
var speed
var movepattern
onready var timer = get_parent().get_node("TimedEffects/Timer")

signal no_health
signal full_health
signal not_full_health

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
	if health == max_health:
		emit_signal("max_health")
	else:
		emit_signal("not_full_health")
		
func change_health(amount):
	health = min(health + amount, max_health)
	if health <= 0:
		emit_signal("no_health")
	if health == max_health:
		emit_signal("max_health")
	else:
		emit_signal("not_full_health")
	
func change_strength(amount):
	strength = max(0, strength + amount)

func change_speed(amount):
	speed = clamp(max(0, speed + amount), 1, 1000000)

func set_strength(value):
	strength = value

func set_speed(value):
	speed = value

func set_movepattern(value):
	movepattern = value

func set_timer(value):
	timer.start(value)
