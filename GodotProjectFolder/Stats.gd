extends Node

export (int) var max_health
onready var health = max_health

export (int) var strength

export (int) var speed

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
	
func change_health(amount):
	health += amount
	if health <= 0:
		emit_signal("no_health")
	
func set_strength(value):
	strength = value
	
func set_speed(value):
	speed = value

