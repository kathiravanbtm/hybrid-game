extends Panel

var panel_data = {}
var resize_count = 0
var style_applied = false

func _ready():
	setup_panel_data()

func setup_panel_data():
	panel_data = {
		"size": size,
		"position": position,
		"modulate": modulate,
		"visible": visible
	}

func resize_panel(new_size: Vector2):
	size = new_size
	panel_data["size"] = new_size
	resize_count += 1

func move_panel(new_position: Vector2):
	position = new_position
	panel_data["position"] = new_position

func set_panel_color(color: Color):
	modulate = color
	panel_data["modulate"] = color

func toggle_panel_visibility():
	visible = !visible
	panel_data["visible"] = visible

func get_panel_info():
	return {
		"data": panel_data,
		"resize_count": resize_count,
		"style_applied": style_applied,
		"children_count": get_child_count()
	}

func apply_style():
	style_applied = true
	# Apply some visual changes
	modulate = Color(randf(), randf(), randf(), 1.0)

func reset_panel_style():
	style_applied = false
	modulate = Color.WHITE

func animate_panel_size(target_size: Vector2, duration: float):
	var tween = create_tween()
	tween.tween_method(resize_panel, size, target_size, duration)

func pulse_panel():
	var original_size = size
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)

func center_panel():
	var parent_size = get_parent().size if get_parent() is Control else Vector2(1024, 600)
	position = (parent_size - size) / 2

func fit_to_content():
	if get_child_count() > 0:
		var total_size = Vector2.ZERO
		for child in get_children():
			if child is Control:
				total_size = total_size.max(child.position + child.size)
		resize_panel(total_size + Vector2(20, 20))
