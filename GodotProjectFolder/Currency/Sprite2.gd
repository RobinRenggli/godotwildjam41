extends Sprite

onready var orig_scale = scale
export var time = 0.0
export var speed = 2.0
export var power = 0.4

func _process(delta):
	time = wrapf(time+delta*speed,-PI,PI)
	scale = orig_scale + orig_scale * sin(time) * power
