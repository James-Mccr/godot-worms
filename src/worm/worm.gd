extends Node2D

const base_rotation = 2
var max_speed = Vector2(50, 0)
var speed := Vector2(0, 0)
var brake_speed = Vector2(1, 0)
var acceleration := Vector2(0.5, 0)
var deceleration := Vector2(0.25, 0)

func _ready():
	$Body1/Follower.leader = $Head
	$Body2/Follower.leader = $Body1
	$Body3/Follower.leader = $Body2
	$Tail/Follower.leader = $Body3

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
