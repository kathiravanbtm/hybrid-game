extends Node2D

@onready var map: TileMapLayer = $TileMap/map

func _ready():
	pass

# Function to replace a tile at a given position
func replace_tile_at_position(p_position: Vector2i, new_source_id: int, new_atlas_coords: Vector2i):
	if map == null:
		print("ERROR: Cannot replace tile, TileMapLayer 'map' is null. Aborting.")
		return

	map.set_cell(p_position, new_source_id, new_atlas_coords)


const TILE_ID = 6
const TILE_COORD = Vector2i(56, -8)

func _on_trigger_area_body_entered(body):
	if body.name == "player":
	
		var tile_position = Vector2i(56, -8)

		print("\n--- Initiating Tile Replacement ---")
		replace_tile_at_position(tile_position, 11, Vector2i(0, 0)) # <--- CHANGED THIS LINE!
	else:
		pass
	
