extends KinematicBody2D

onready var Stats = $Stats
onready var Movement = $Movement
onready var CreatureSprite = $Sprite

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	Movement.move(Stats.speed * delta * Constants.delta_factor, CreatureSprite)

func _on_Body_area_entered(area):
	PlayerStats.change_currency(1)
