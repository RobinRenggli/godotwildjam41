extends Node2D

export var speed = 4
export var strength = 1
var sprites = [
	preload("res://Debris/BlueCan.png"),
	preload("res://Debris/GreenCan.png"),
	preload("res://Debris/RedCan.png"),
	preload("res://Debris/YelliowCan.png")
]

func _ready():
	$Sprite.texture = sprites[randi()%4]
	rotation_degrees = rand_range(0, 360)

func _physics_process(delta):
	global_position += Vector2(0, delta * speed * Constants.delta_factor)


func _on_Area2D_area_entered(area):
	queue_free()
