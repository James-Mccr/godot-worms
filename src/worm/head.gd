extends Area2D

signal pickup
signal eaten

func _on_area_entered(area):
	match(area.collision_layer):
		2:
			area.queue_free()
		4:
			$AudioStreamPlayer.play()
			area.respawn()
			pickup.emit()
		8:
			eaten.emit()
