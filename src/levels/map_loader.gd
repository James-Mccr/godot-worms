extends Node2D

var soil_scene = preload("res://levels/soil_tile2.tscn")
var player
var last_tile : Vector2i
var tiles = []
const x_radius := 2
const y_radius := 2
const x_diameter = x_radius*2+1
const y_diameter = y_radius*2+1
const tile_size = 16
const tile_offset = 8

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	last_tile = position_to_tile(player.position)
	for y in range(0, y_diameter):
		for x in range(0, x_diameter):
			var soil = soil_scene.instantiate()
			var tile = last_tile+Vector2i(x-x_radius, y-y_radius)
			var tile_position = tile_to_position(tile)
			soil.set_tile_position(tile_position, tile)
			tiles.append(soil)
			add_child(soil)
	
func _process(_delta):
	var player_tile = position_to_tile(player.global_position)
	if last_tile.x != player_tile.x:
		var x_shift = player_tile.x-last_tile.x
		last_tile.x = player_tile.x
		
		# delete out-of-range tiles
		var tiles_to_delete = []
		for soil_tile in tiles:
			if (abs(player_tile.x - soil_tile.tile.x) > x_radius):
				tiles_to_delete.append(soil_tile)
		
		for tile in tiles_to_delete:
			tiles.erase(tile)
			tile.queue_free()
		
		# add new tiles
		var radius_shift = x_shift * x_radius
		for y in range(0, y_diameter):
			var soil = soil_scene.instantiate()
			var new_tile = Vector2i(player_tile.x+radius_shift, player_tile.y+y-y_radius)
			var tile_position = tile_to_position(new_tile)
			soil.set_tile_position(tile_position, new_tile)
			tiles.append(soil)
			add_child(soil)	
		
	elif last_tile.y != player_tile.y:
		var y_shift = player_tile.y-last_tile.y
		last_tile.y = player_tile.y
		
		# delete out-of-range tiles
		var tiles_to_delete = []
		for soil_tile in tiles:
			if (abs(player_tile.y - soil_tile.tile.y) > y_radius):
				tiles_to_delete.append(soil_tile)
		
		for tile in tiles_to_delete:
			tiles.erase(tile)
			tile.queue_free()
		
		# add new tiles
		var radius_shift = y_shift * y_radius
		for x in range(0, x_diameter):
			var soil = soil_scene.instantiate()
			var new_tile = Vector2i(player_tile.x+x-x_radius, player_tile.y+radius_shift)
			var tile_position = tile_to_position(new_tile)
			soil.set_tile_position(tile_position, new_tile)
			tiles.append(soil)
			add_child(soil)	

func position_to_tile(_position:Vector2)->Vector2i:
	@warning_ignore("integer_division")
	var x_tile := int(_position.x+tile_offset) / tile_size 
	if _position.x < 0:
		x_tile -= 1
	@warning_ignore("integer_division")
	var y_tile := int(_position.y+tile_offset) / tile_size
	if _position.y < 0:
		y_tile -= 1
	return Vector2i(x_tile, y_tile)

func tile_to_position(tile:Vector2i)->Vector2:
	var x_pos = tile.x*tile_size+tile_offset
	var y_pos = tile.y*tile_size+tile_offset
	return Vector2(x_pos, y_pos)
