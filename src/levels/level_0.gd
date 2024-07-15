extends Node

var map = preload("res://levels/soil_tile.tscn")
var width = 15
var height = 15
var length = 32

func _ready():
	var x_offset = 0
	var y_offset = 0
	for w in range(width):
		for h in range(height):
			var tile = map.instantiate()
			tile.get_child(0).position.x = x_offset
			tile.get_child(0).position.y = y_offset
			y_offset += length			
			add_child(tile)
		x_offset += length
		y_offset = 0
	$Sun.spawn()
