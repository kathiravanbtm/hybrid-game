extends CenterContainer

var centering_data = {}
var content_centered = true
var animation_active = false

func _ready():
	setup_centering_data()

func setup_centering_data():
	centering_data = {
		"centered": content_centered,
		"container_size": size,
		"content_size": Vector2.ZERO,
		"offset": Vector2.ZERO
	}

func update_centering_data():
	centering_data["container_size"] = size
	calculate_content_size()

func calculate_content_size():
	var total_size = Vector2.ZERO
	for child in get_children():
		if child is Control:
			total_size = total_size.max(child.size)
	centering_data["content_size"] = total_size

func animate_center_effect():
	if animation_active:
		return
	animation_active = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.3)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	await tween.finished
	animation_active = false

func get_centering_info():
	update_centering_data()
	return {
		"data": centering_data,
		"centered": content_centered,
		"animating": animation_active,
		"children_count": get_child_count()
	}

func toggle_centering():
	content_centered = !content_centered
	centering_data["centered"] = content_centered

func pulse_container():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate:a", 0.7, 0.5)
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func fit_container_to_content():
	calculate_content_size()
	size = centering_data["content_size"] + Vector2(20, 20)

func center_in_parent():
	if get_parent() is Control:
		var parent_size = get_parent().size
		position = (parent_size - size) / 2

func reset_container():
	scale = Vector2(1.0, 1.0)
	modulate = Color.WHITE
	content_centered = true

func get_center_offset():
	return (size - centering_data["content_size"]) / 2

func is_content_fitting():
	return centering_data["content_size"].x <= size.x and centering_data["content_size"].y <= size.y
