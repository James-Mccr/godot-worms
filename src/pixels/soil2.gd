extends Sprite2D

var player

func _ready():
	player = get_tree().get_first_node_in_group("Player")	

func _process(_delta):
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = player.get_node("CollisionShape2D").shape
	query.collide_with_bodies = false
	query.collide_with_areas = true
	query.collision_mask = 1
	query.transform = global_transform
	
	var result := get_world_2d().direct_space_state.intersect_shape(query, 1)
	if (result):
		queue_free()
