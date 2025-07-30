extends VSeparator

var separator_config = {}
var width_value = 2.0
var gradient_effect = false

func _ready():
	setup_separator_config()

func setup_separator_config():
	separator_config = {
		"width": width_value,
		"gradient": gradient_effect,
		"position": position,
		"size": size
	}

func set_separator_width(width: float):
	width_value = width
	separator_config["width"] = width
	custom_minimum_size.x = width

func toggle_gradient_effect():
	gradient_effect = !gradient_effect
	separator_config["gradient"] = gradient_effect
	apply_gradient()

func apply_gradient():
	if gradient_effect:
		var gradient_tween = create_tween()
		gradient_tween.set_loops()
		gradient_tween.tween_property(self, "modulate", Color.CYAN, 1.0)
		gradient_tween.tween_property(self, "modulate", Color.MAGENTA, 1.0)

func get_separator_config():
	return {
		"config": separator_config,
		"width": width_value,
		"gradient": gradient_effect,
		"visible": visible
	}

func animate_width(target_width: float, duration: float):
	var tween = create_tween()
	tween.tween_method(set_separator_width, width_value, target_width, duration)

func flash_separator():
	var original_color = modulate
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	tween.tween_property(self, "modulate", original_color, 0.1)

func reset_separator_config():
	set_separator_width(2.0)
	gradient_effect = false
	modulate = Color.WHITE

func scale_separator(factor: float):
	scale = Vector2(factor, scale.y)

func move_separator_to(target_pos: Vector2, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "position", target_pos, duration)

func get_separator_bounds():
	return Rect2(position, size)

func is_separator_visible():
	return visible and modulate.a > 0.0
