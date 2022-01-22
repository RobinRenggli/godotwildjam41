extends Node

export var amount = 2

func execute(type):
	for i in range(amount):
		Overviewer.evolutionQueue.push_front(type)
