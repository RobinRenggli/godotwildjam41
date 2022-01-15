extends Node

export var currency = 5

signal currency_changed

func change_currency(amount):
	currency += amount
	emit_signal("currency_changed")

func reset_currency():
	currency = 5
	
