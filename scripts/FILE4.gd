extends Node2D

var position_data = Vector2.ZERO
var rotation_speed = 1.0
var scale_factor = 1.0

func _ready():
	position_data = Vector2(100, 200)
	rotation_speed = randf() * 2.0

func update_position(new_pos: Vector2):
	position_data = new_pos

func rotate_dummy():
	rotation += rotation_speed * 0.1

func scale_dummy(factor: float):
	scale_factor *= factor
	scale = Vector2(scale_factor, scale_factor)

func get_distance_to(target: Vector2):
	return position_data.distance_to(target)

func normalize_data():
	if position_data.length() > 0:
		position_data = position_data.normalized()

func random_movement():
	var random_offset = Vector2(randf() * 10, randf() * 10)
	position_data += random_offset

func cleanup_data():
	position_data = Vector2.ZERO
	scale_factor = 1.0



func lerp_to_target(target: Vector2, weight: float):
	position_data = position_data.lerp(target, weight)
	return position_data
