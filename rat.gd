extends Node2D

@onready var tile_map = $"../TileMap"
@onready var sprite_2d: Sprite2D = $Sprite2D

var is_moving = false

var current_tile : Vector2i
var next_tile : Vector2i
var auto_next_tile : Vector2i 

func _physics_process(delta: float) -> void:
	if is_moving == false:
		return
	
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
		
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)

func _process(delta):
	auto_next_tile = Vector2i.ZERO
	if is_moving:
		return
		
	if Input.is_action_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		move(Vector2.RIGHT)


func move(direction: Vector2):
	
	current_tile = tile_map.local_to_map(global_position)

	next_tile = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	var tile_data: TileData = tile_map.get_cell_tile_data(0, next_tile)
	var path_data: TileData = tile_map.get_cell_tile_data(1, next_tile)
	
	if tile_data == null:
		return
	
	if path_data:
		if path_data.get_custom_data("spike"):
			self.queue_free()
	
		if path_data.get_custom_data("right"):
			auto_next_tile = Vector2i(
				next_tile.x + 1,
				next_tile.y + 0
			)
		elif path_data.get_custom_data("left"):
			auto_next_tile = Vector2i(
				next_tile.x + -1,
				next_tile.y + 0
			)
		elif path_data.get_custom_data("bottom"):
			auto_next_tile = Vector2i(
				next_tile.x + 0,
				next_tile.y + 1
			)
		elif path_data.get_custom_data("top"):
			auto_next_tile = Vector2i(
				next_tile.x + 0,
				next_tile.y + -1
			)
		
	if tile_data.get_custom_data("walkable") == false:
		return
		
	is_moving = true
	global_position = tile_map.map_to_local(next_tile)
	sprite_2d.global_position = tile_map.map_to_local(current_tile)
	
	if auto_next_tile != Vector2i.ZERO:
		
		var auto_path_data: TileData = tile_map.get_cell_tile_data(1, auto_next_tile)
		if auto_path_data:
			if auto_path_data.get_custom_data("spike"):
				self.queue_free()
		
		global_position = tile_map.map_to_local(auto_next_tile)
		sprite_2d.global_position = tile_map.map_to_local(next_tile)
	
