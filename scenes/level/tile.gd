extends Node2D
@onready var tile_map = $TileMap
@onready var game_manager = $GameManager
@onready var spike: Node2D = $SpikeHide

# Listen for mouse click events
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_position = get_local_mouse_position()
		var tile_position = tile_map.local_to_map(mouse_position)
		
		rotate_flip_tile(tile_position)

func rotate_flip_tile(tile_position):
	
	var current_tile: TileData = tile_map.get_cell_tile_data(1, tile_position)
	
	if(current_tile == null):
		return
		
	# Check if there's a current tile flipable
	if  current_tile.get_custom_data("flipable") == false:
		return
		
	var current_atlas: Vector2i = tile_map.get_cell_atlas_coords(1, tile_position)
	
	
	# Modify the transformation flags (rotate + flip logic)
	rotate_tile(current_atlas, tile_position)

func rotate_tile(currentAtlas, tile_position):
	
	var change : Vector2i
	if currentAtlas == Vector2i(0, 0):
		change = Vector2i(2, 0)
	elif currentAtlas == Vector2i(2, 0):
		change = Vector2i(1, 0)
	elif currentAtlas == Vector2i(1, 0):
		change = Vector2i(3, 0)
	elif currentAtlas == Vector2i(3, 0):
		change = Vector2i(0, 0)
	
	
	tile_map.set_cell(1, tile_position, 1, change, 0)
		
