extends Node
class_name Follower

@export var leader:Area2D
var follower:Area2D
var base_speed = Globals.worm_speed

func _ready():
	follower = get_parent()

func follow(delta:float):
	if (follower.position.distance_to(leader.position) > 6):
		follower.position += base_speed.rotated(follower.rotation)*delta
		#$Body1.rotation += $Body1.get_angle_to($Head.position)
	follower.rotation = follower.position.angle_to_point(leader.position)
