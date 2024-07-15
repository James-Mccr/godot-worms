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
	length = get_parent().length
	width = get_parent().width
	height = get_parent().height

func _process(_delta):
	var distance = $AudioStreamPlayer2D.global_position.distance_to(player.position) 
	var relative_pitch
	if distance > 300:
		$AudioStreamPlayer2D.stop()
		return
	if distance > 200:
		relative_pitch = 0.75
	elif distance > 150:
		relative_pitch = 1
	elif distance > 100:
		relative_pitch = 1.25
	elif distance > 50:
		relative_pitch = 1.5
	elif distance > 25:
		relative_pitch = 1.75
	else:
		relative_pitch = 2
		
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D.pitch_scale = relative_pitch

func spawn():
	position = Vector2(randi_range(0, (width-1)*length), randi_range(0, (height-1)*length))

func respawn():
	$GPUParticles2D.position = position
	$GPUParticles2D.emitting = true
	position = Vector2(randi_range(0, (width-1)*length), randi_range(0, (height-1)*length))
