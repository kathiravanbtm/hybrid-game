extends MarginContainer

var margin_data = {}
var spacing_value = 10.0
var content_size = Vector2.ZERO

func _ready():
	setup_margin_data()

func setup_margin_data():
	margin_data = {
		"left": 0,
		"right": 0,
		"top": 0,
		"bottom": 0,
		"spacing": spacing_value
	}

func set_margins(left: int, top: int, right: int, bottom: int):
	margin_data["left"] = left
	margin_data["right"] = right
	margin_data["top"] = top
	margin_data["bottom"] = bottom
	
	add_theme_constant_override("margin_left", left)
	add_theme_constant_override("margin_right", right)
	add_theme_constant_override("margin_top", top)
	add_theme_constant_override("margin_bottom", bottom)

func set_uniform_margin(margin: int):
	set_margins(margin, margin, margin, margin)

func animate_margins(target_margins: Vector4, duration: float):
	var tween = create_tween()
	var current = Vector4(margin_data["left"], margin_data["top"], margin_data["right"], margin_data["bottom"])
	tween.tween_method(apply_animated_margins, current, target_margins, duration)

func apply_animated_margins(margins: Vector4):
	set_margins(int(margins.x), int(margins.y), int(margins.z), int(margins.w))

func get_margin_info():
	return {
		"data": margin_data,
		"content_size": content_size,
		"total_size": size,
		"children_count": get_child_count()
	}

func calculate_content_size():
	content_size = Vector2.ZERO
	for child in get_children():
		if child is Control:
			content_size = content_size.max(child.size)

func fit_to_content():
	calculate_content_size()
	var total_margin = Vector2(margin_data["left"] + margin_data["right"], margin_data["top"] + margin_data["bottom"])
	size = content_size + total_margin

func pulse_margins():
	var original_margins = Vector4(margin_data["left"], margin_data["top"], margin_data["right"], margin_data["bottom"])
	var expanded_margins = original_margins + Vector4(10, 10, 10, 10)
	animate_margins(expanded_margins, 0.2)
	await get_tree().create_timer(0.2).timeout
	animate_margins(original_margins, 0.2)

func reset_margins():
	set_uniform_margin(0)
