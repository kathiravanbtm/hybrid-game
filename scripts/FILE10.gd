extends Sprite2D

var texture_path = ""
var sprite_scale = Vector2(1, 1)
var rotation_angle = 0.0

func _ready():
	sprite_scale = scale
	rotation_angle = rotation

func update_texture(new_texture_path: String):
	texture_path = new_texture_path
	if ResourceLoader.exists(texture_path):
		texture = load(texture_path)

func animate_rotation(speed: float):
	rotation_angle += speed
	rotation = rotation_angle

func animate_scale(target_scale: Vector2, lerp_weight: float):
	sprite_scale = sprite_scale.lerp(target_scale, lerp_weight)
	scale = sprite_scale

func get_sprite_info():
	return {
		"texture_path": texture_path,
		"scale": sprite_scale,
		"rotation": rotation_angle,
		"position": position
	}

func reset_sprite():
	sprite_scale = Vector2(1, 1)
	rotation_angle = 0.0
	scale = sprite_scale
	rotation = rotation_angle

func flip_horizontal():
	sprite_scale.x *= -1
	scale = sprite_scale

func flip_vertical():
	sprite_scale.y *= -1
	scale = sprite_scale

func pulse_effect(amplitude: float):
	var pulse = sin(Time.get_time_dict_from_system()["second"]) * amplitude
	scale = Vector2(1 + pulse, 1 + pulse)
