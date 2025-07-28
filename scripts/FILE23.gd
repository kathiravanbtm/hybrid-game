extends VSlider

var slider_data = 50.0
var step_size = 1.0
var snap_enabled = false

func _ready():
	value = slider_data
	step = step_size
	connect("value_changed", _on_value_changed)

func _on_value_changed(new_value: float):
	slider_data = new_value
	print("Slider value changed: ", slider_data)

func set_slider_value(new_value: float):
	slider_data = clamp(new_value, min_value, max_value)
	value = slider_data

func set_step_size(new_step: float):
	step_size = new_step
	step = step_size

func toggle_snap():
	snap_enabled = !snap_enabled
	
func get_slider_info():
	return {
		"value": slider_data,
		"min": min_value,
		"max": max_value,
		"step": step_size,
		"snap": snap_enabled
	}

func reset_slider():
	set_slider_value((min_value + max_value) / 2)

func animate_slider_to(target: float, duration: float):
	var tween = create_tween()
	tween.tween_method(set_slider_value, slider_data, target, duration)

func set_slider_range(min_val: float, max_val: float):
	min_value = min_val
	max_value = max_val

func increment_slider():
	set_slider_value(slider_data + step_size)

func decrement_slider():
	set_slider_value(slider_data - step_size)

func get_percentage():
	return (slider_data - min_value) / (max_value - min_value) * 100
