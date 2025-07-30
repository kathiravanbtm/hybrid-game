extends HSeparator

var separator_data = {}
var thickness_value = 2.0
var color_data = Color.GRAY

func _ready():
	setup_separator_data()

func setup_separator_data():
	separator_data = {
		"thickness": thickness_value,
		"color": color_data,
		"size": size,
		"visible": visible
	}

func set_separator_thickness(thickness: float):
	thickness_value = thickness
	separator_data["thickness"] = thickness
	custom_minimum_size.y = thickness

func set_separator_color(color: Color):
	color_data = color
	separator_data["color"] = color
	modulate = color

func animate_separator():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func get_separator_info():
	return {
		"data": separator_data,
		"thickness": thickness_value,
		"color": color_data,
		"size": size
	}

func pulse_separator():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate:a", 0.3, 1.0)
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func hide_separator():
	visible = false
	separator_data["visible"] = false

func show_separator():
	visible = true
	separator_data["visible"] = true

func toggle_separator():
	visible = !visible
	separator_data["visible"] = visible

func reset_separator():
	set_separator_thickness(2.0)
	set_separator_color(Color.GRAY)
	show_separator()

func fade_in_separator(duration: float):
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)

func fade_out_separator(duration: float):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration)
