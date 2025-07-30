extends StaticBody2D

var collision_count = 0
var body_type = "static"
var material_friction = 0.5

func _ready():
	body_type = "dummy_static"
	material_friction = randf()

func handle_collision():
	collision_count += 1
	print("Collision detected: ", collision_count)

func set_friction(value: float):
	material_friction = clamp(value, 0.0, 1.0)

func get_collision_info():
	return {
		"count": collision_count,
		"type": body_type,
		"friction": material_friction
	}

func reset_collision_count():
	collision_count = 0

func simulate_collision():
	handle_collision()
	return collision_count

func get_body_properties():
	var properties = {}
	properties["mass"] = 10.0
	properties["bounce"] = 0.3
	properties["friction"] = material_friction
	return properties

func update_body_type(new_type: String):
	body_type = new_type

func calculate_impact_force(velocity: Vector2):
	return velocity.length() * 2.5

func is_collision_threshold_reached(threshold: int):
	return collision_count >= threshold
