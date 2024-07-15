extends Area2D

func _on_area_entered(area):
	match(area.collision_layer):
		2:
			area.queue_free()
		4:
			$AudioStreamPlayer.play()
			get_parent().max_speed.x += 10
			area.respawn()
		8:
			rotation_degrees += 180 
