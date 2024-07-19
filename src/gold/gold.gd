extends Area2D

var player : Area2D
const base_distance = 100.0
const min_pitch = 1.0
const max_pitch = 1.5
var width
var height
var length

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func spawn():
	position = Vector2(randi_range(-12, width*length-20), randi_range(-12, height*length-20))

func respawn():
	$GPUParticles2D.position = position
	$GPUParticles2D.emitting = true
	spawn()

func _process(_delta):
	if is_queued_for_deletion():
		return
	# loudness based on facing the target gold
	#var vector_to_target = global_position - player.global_position
	#var dot_angle = Vector2.RIGHT.rotated(player.rotation).dot(vector_to_target.normalized())
	#var volume_mod = dot_angle*10
	#$AudioStreamPlayer2D.volume_db = volume_mod
	
	var distance = $AudioStreamPlayer2D.global_position.distance_to(player.global_position) 
	var relative_pitch
	if distance > 300:
		relative_pitch = 0.5
	elif distance > 200:
		relative_pitch = 0.75
	elif distance > 150:
		relative_pitch = 1
	elif distance > 100:
		relative_pitch = 1.25
	elif distance > 50:
		relative_pitch = 1.5
	elif distance > 25:
		relative_pitch = 1.75
	elif distance > 12:
		relative_pitch = 2
	else:
		relative_pitch = 3
	$AudioStreamPlayer2D.pitch_scale = relative_pitch

func disable():
	set_process(false)
	$AudioStreamPlayer2D.stop()
	hide()
