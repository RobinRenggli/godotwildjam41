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
	preload("res://Evolution/Cards/SpawnCurrency.tscn"),
	preload("res://Evolution/Cards/HealingAura.tscn"),
	preload("res://Evolution/Cards/SpawnCreaturePerWave.tscn"),
	]
var Random = RandomNumberGenerator.new()
var evolution_in_progress = false

func _ready():
	Random.randomize()
	visible = false
	CreatureInfo.connect("evolve_creature", self, "_on_evolve_creature")

func _on_evolve_creature():
	if evolution_in_progress:
		return
	evolution_in_progress = true
	AudioController.get_node("LevelUpSound").play()
	var type = Overviewer.evolutionQueue.pop_front()
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
	Overviewer.resume_game()
	visible = false
	for card in $CardContainer.get_children():
		card.queue_free()
	var t = Timer.new()
	t.set_wait_time(0.001)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	evolution_in_progress = false
	AudioController.get_node("SelectEvolutionSound").play()
	if not Overviewer.evolutionQueue.empty():
		_on_evolve_creature()
