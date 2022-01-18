extends Control

export var cards_shown = 3
export (Array, Resource) var cards = []
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
