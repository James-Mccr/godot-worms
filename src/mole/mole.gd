extends Area2D

var speed := 10
var target : Area2D

func _ready():
	target = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if target.visible:
		var last_angle = rotation
		rotation = (target.global_position - global_position).angle()
		var diff_angle = abs(last_angle - rotation)
		var speed_mult = 1
		if (rad_to_deg(diff_angle) > 0.1):
			speed_mult = 0.5
		position += position.direction_to(target.global_position)*speed*delta*speed_mult
	else:
		position += Vector2.RIGHT.rotated(rotation)*speed*delta
		
func _on_timer_timeout():
	speed += 1
	$AudioStreamPlayer.play(0.5)
