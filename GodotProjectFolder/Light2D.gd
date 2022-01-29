extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	self.energy += rand_range(-0.01, 0.01)
	self.energy = min(self.energy, 1.1)
	self.energy = max(self.energy, 0.9)
