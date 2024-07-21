extends Node2D

func _ready():
	$Worm/Head/Camera2D.zoom = Vector2i(7, 7)
	$Gold.width = 200
	$Gold.height = 200
	$Gold.spawn()
	$Worm.connect("player_eaten", gameover)
	
func gameover():
	$Worm.disable()
	$Gold.disable()
	
