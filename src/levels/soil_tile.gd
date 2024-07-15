extends Node

func _ready():
	$VisibleOnScreenNotifier2D.position = $TileMap.position

func _on_visible_on_screen_notifier_2d_screen_entered():
	$TileMap.show()

func _on_visible_on_screen_notifier_2d_screen_exited():
	$TileMap.hide()
