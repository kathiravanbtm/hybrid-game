extends ProgressBar

var progress_data = 0.0
var target_value = 100.0
var animation_speed = 2.0

func _ready():
	value = progress_data
	max_value = target_value

func set_progress_value(new_value: float):
	progress_data = clamp(new_value, min_value, max_value)
	value = progress_data

func animate_to_value(target: float, duration: float):
	target = clamp(target, min_value, max_value)
	var tween = create_tween()
	tween.tween_method(set_progress_value, progress_data, target, duration)

func increment_progress(amount: float):
	set_progress_value(progress_data + amount)

func decrement_progress(amount: float):
	set_progress_value(progress_data - amount)

func get_progress_info():
	return {
		"current": progress_data,
		"max": max_value,
		"min": min_value,
		"percentage": (progress_data / max_value) * 100
	}

func reset_progress():
	set_progress_value(min_value)

func fill_progress():
	set_progress_value(max_value)

func set_progress_range(min_val: float, max_val: float):
	min_value = min_val
	max_value = max_val
	target_value = max_val

func pulse_progress():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate:a", 0.5, 0.5)
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func is_complete():
	return progress_data >= max_value
