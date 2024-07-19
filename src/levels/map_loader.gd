extends Node2D

var soil_scene = preload("res://levels/soil_tile.tscn")
var player
var last_tile : Vector2i
var tiles = []
const tile_radius := 1
const tile_diameter = tile_radius*2+1
const tile_size = 32
const tile_offset = 16

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	last_tile = position_to_tile(player.position)
	for y in range(0, tile_diameter):
		for x in range(0, tile_diameter):
			var soil = soil_scene.instantiate()
			var tile_position = tile_to_position(last_tile+Vector2i(x-tile_radius, y-tile_radius))
			soil.position = tile_position
			tiles.append(soil)
			add_child(soil)
	
func _process(_delta):
	var player_tile = position_to_tile(player.position)
	if last_tile.x != player_tile.x:
		var x_shift = player_tile.x-last_tile.x
		last_tile.x = player_tile.x
		
		# delete out-of-range tiles
		var tiles_to_delete = []
		for tile in tiles:
			var cell = position_to_tile(tile.position)
			if (abs(player_tile.x - cell.x) > tile_radius):
				tiles_to_delete.append(tile)
		
		for tile in tiles_to_delete:
			tiles.erase(tile)
			tile.queue_free()
		
		# add new tiles
		for y in range(0, tile_diameter):
			var soil = soil_scene.instantiate()
			var new_tile = Vector2i(last_tile.x+x_shift, last_tile.y+y-1)
			var tile_position = tile_to_position(new_tile)
			soil.position = tile_position
			tiles.append(soil)
			add_child(soil)	 # is slow. try simple soil object?
		
	if last_tile.y != player_tile.y:
		pass

func position_to_tile(tile:Vector2)->Vector2i:
	var x_tile = tile.x/tile_size
	if x_tile < 0:
		x_tile -= 1
	var y_tile = tile.y/tile_size
	if y_tile < 0:
		y_tile -= 1
	return Vector2i(int(x_tile), int(y_tile))

func tile_to_position(tile:Vector2i)->Vector2:
	var x_tile = tile.x*tile_size+tile_offset
	var y_tile = tile.y*tile_size+tile_offset
	return Vector2(x_tile, y_tile)
