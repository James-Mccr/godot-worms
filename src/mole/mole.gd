extends Area2D

var speed := 20
var player : Area2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	rotation = (player.global_position - global_position).angle()
	position += position.direction_to(player.position)*speed*delta


func _on_timer_timeout():
	speed += 5
	$AudioStreamPlayer.play(0.5)
	$GPUParticles2D.emitting = true
