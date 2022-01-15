extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(PlayerStats.currency)
	PlayerStats.connect("currency_changed", self, "_on_currency_changed")

func _on_currency_changed():
	text = str(PlayerStats.currency)
