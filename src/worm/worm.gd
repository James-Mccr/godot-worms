extends Node2D

signal player_eaten

const base_rotation = 2
var max_speed = Vector2(40, 0)
var speed := Vector2(0, 0)
var brake_speed = Vector2(1, 0)
var acceleration := Vector2(0.5, 0)
var deceleration := Vector2(0.25, 0)
var nuggets = 0

func _ready():
	$Body1/Follower.leader = $Head
	$Body2/Follower.leader = $Body1
	$Body3/Follower.leader = $Body2
	$Tail/Follower.leader = $Body3
	$Head.connect("pickup", gold_got)
	$Head.connect("eaten", eaten)

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		speed += acceleration
		if (speed.x > max_speed.x):
			speed.x = max_speed.x
	else:
		if Input.is_action_pressed("down"):
			speed -= brake_speed
		else:
			speed -= deceleration
		if (speed.x < 0):
			speed.x = 0	

	if Input.is_action_pressed("left"):
		$Head.rotation_degrees -= base_rotation
	elif Input.is_action_pressed("right"):
		$Head.rotation_degrees += base_rotation
			
	$Head.position += speed.rotated($Head.rotation)*delta
	$Body1/Follower.follow()
	$Body2/Follower.follow()
	$Body3/Follower.follow()
	$Tail/Follower.follow()

func gold_got():
	max_speed.x += 5
	nuggets += 1
	if nuggets == 5:
		$AudioStreamPlayer2.play()
		$Question.show()
		$QuestionTimer.start()
		$SpawnTimer.start()

func disable():
	set_physics_process(false)
	hide()

func eaten():
	$Head/Camera2D/Hud.over()
	player_eaten.emit()

func _on_timer_timeout():
	$Alert.show()
	$AudioStreamPlayer.play()
	$AlertTimer.start()
	var mole = preload("res://mole/mole.tscn").instantiate()
	mole.position = global_position + Vector2(225, 0).rotated(randf_range(0, 2*PI))
	get_parent().add_child(mole)

func _on_alert_timer_timeout():
	$Alert.hide()

func _on_question_timer_timeout():
	$Question.hide()
