extends CanvasLayer

signal play_again

func over(score:int):
	$Score.text = str(score)
	$Score.show()
	$OverLabel.show()
	$Button.show()

func _on_button_pressed():
	get_tree().reload_current_scene()
