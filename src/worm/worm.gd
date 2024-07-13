extends Node2D

const base_speed = Globals.worm_speed
const base_rotation = 1.5

# add momentum/physics

func _ready():
	$Body1/Follower.leader = $Head
	$Body2/Follower.leader = $Body1
	$Body3/Follower.leader = $Body2
	$Tail/Follower.leader = $Body3

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		$Head.position += base_speed.rotated($Head.rotation)*delta
		$Body1/Follower.follow(delta)
		$Body2/Follower.follow(delta)
		$Body3/Follower.follow(delta)
		$Tail/Follower.follow(delta)
	if Input.is_action_pressed("left"):
		$Head.rotation_degrees -= base_rotation
	elif Input.is_action_pressed("right"):
		$Head.rotation_degrees += base_rotation
		

