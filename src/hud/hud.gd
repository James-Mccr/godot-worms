extends CanvasLayer

func update_gold_count(count:int):
	$GoldCount.text = str(count)

func alert_mole():
	$MoleAlert.show()
	$Timer.start()

func over():
	$OverLabel.show()

func _on_timer_timeout():
	$MoleAlert.hide()
