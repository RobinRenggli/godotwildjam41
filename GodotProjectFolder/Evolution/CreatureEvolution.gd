extends Control

export var cards_shown = 3
export (Array, Resource) var cards = []
var Random = RandomNumberGenerator.new()

func _ready():
	randomize()
	visible = false
	CreatureInfo.connect("evolve_creature", self, "_on_evolve_creature")

func _on_evolve_creature(creature):
	visible = true
	Overviewer.pause_game()
	for i in range(cards_shown):
		var card = cards[Random.randi_range(0, cards.size() - 1)].instance()
		card.connect("evolution_selected", self, "_on_evolution_selected")
		card.type = creature
		$CardContainer.add_child(card)

func _on_evolution_selected():
	visible = false
	for card in $CardContainer.get_children():
		card.queue_free()
	Overviewer.resume_game()
