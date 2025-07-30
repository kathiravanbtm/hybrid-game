extends Camera2D

var zoom_level = Vector2(1, 1)
var follow_target: Node2D
var smooth_factor = 5.0

func _ready():
	zoom = zoom_level
	enabled = true

func _process(delta):
	if follow_target:
		smooth_follow(delta)

func smooth_follow(delta):
	var target_position = follow_target.global_position
	global_position = global_position.lerp(target_position, smooth_factor * delta)

func set_zoom_level(new_zoom: Vector2):
	zoom_level = new_zoom
	zoom = zoom_level

func zoom_in(factor: float = 1.2):
	zoom_level *= factor
	zoom = zoom_level

func zoom_out(factor: float = 0.8):
	zoom_level *= factor
	zoom = zoom_level

func set_follow_target(target: Node2D):
	follow_target = target

func shake_camera(intensity: float, duration: float):
	var original_pos = position
	var tween = create_tween()
	for i in range(int(duration * 10)):
		var shake_offset = Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		tween.tween_to(position + shake_offset, 0.1)
	tween.tween_to(original_pos, 0.1)

func get_camera_info():
	return {
		"zoom": zoom_level,
		"position": global_position,
		"has_target": follow_target != null,
		"smooth_factor": smooth_factor
	}
