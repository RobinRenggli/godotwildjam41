extends Control

export var cards_shown = 3
var cards = [
	preload("res://Evolution/Cards/AllStatsAndCost.tscn"),
	preload("res://Evolution/Cards/BasicProjectile.tscn"),
	preload("res://Evolution/Cards/ExpOnDeath.tscn"),
	preload("res://Evolution/Cards/HaiGroundMovement.tscn"),
	preload("res://Evolution/Cards/HarvestMovement.tscn"),
	preload("res://Evolution/Cards/HealthIncrease.tscn"),
	preload("res://Evolution/Cards/HuntMovement.tscn"),
	preload("res://Evolution/Cards/IncreaseCurrencyPickup.tscn"),
	preload("res://Evolution/Cards/InstantStrengthIncrease.tscn"),
	preload("res://Evolution/Cards/PinballMovement.tscn"),
	preload("res://Evolution/Cards/SpawnCreatures.tscn"),
	preload("res://Evolution/Cards/SpeedIncrease.tscn"),
	preload("res://Evolution/Cards/StayTogetherMovement.tscn"),
	preload("res://Evolution/Cards/StrengthIncrease.tscn"),
	preload("res://Evolution/Cards/DivideXp.tscn"),
	]
var Random = RandomNumberGenerator.new()

func _ready():
	randomize()
	visible = false
	CreatureInfo.connect("evolve_creature", self, "_on_evolve_creature")

func _on_evolve_creature(type):
	visible = true
	$CreatureRect.texture = CreatureInfo.texture_map[type]
	Overviewer.pause_game()
	var prev_indexes = []
	for i in range(cards_shown):
		var index = -1
		while(index in prev_indexes or index == -1):
			index = Random.randi_range(0, cards.size() - 1)
		prev_indexes.append(index)
		var card = cards[index].instance()
		card.connect("evolution_selected", self, "_on_evolution_selected")
		card.type = type
		$CardContainer.add_child(card)

func _on_evolution_selected():
	visible = false
	for card in $CardContainer.get_children():
		card.queue_free()
	Overviewer.resume_game()
	AudioController.get_node("SelectEvolutionSound").play()
