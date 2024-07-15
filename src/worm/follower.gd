extends Node
class_name Follower

@export var leader:Area2D
var follower:Area2D

func _ready():
	follower = get_parent()

func follow():
	if (follower.position.distance_to(leader.position) > 6):
		var diff = leader.position - follower.position
		var norm = diff.normalized()*6
		var offset = diff - norm
		follower.position += offset
		
	follower.rotation = follower.position.angle_to_point(leader.position)
