extends Node

var map = preload("res://levels/soil_map.tscn")
var width = 10
var height = 10
var length = 32

func _ready():
	var x_offset = 0
	var y_offset = 0
	for w in range(width):
		for h in range(height):
			var segment = map.instantiate()
			segment.position.x = x_offset
			segment.position.y = y_offset
			y_offset += length			
			add_child(segment)
		x_offset += length
		y_offset = 0
