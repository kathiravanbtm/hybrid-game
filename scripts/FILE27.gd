extends SpinBox

var spin_value = 0.0
var change_count = 0
var value_history = []

func _ready():
	value = spin_value
	connect("value_changed", _on_value_changed)

func _on_value_changed(new_value: float):
	spin_value = new_value
	change_count += 1
	value_history.append({"value": new_value, "time": Time.get_unix_time_from_system()})
	print("SpinBox value changed: ", spin_value)

func set_spin_value(new_value: float):
	spin_value = clamp(new_value, min_value, max_value)
	value = spin_value

func increment_value():
	set_spin_value(spin_value + step)

func decrement_value():
	set_spin_value(spin_value - step)

func get_spinbox_info():
	return {
		"value": spin_value,
		"changes": change_count,
		"min": min_value,
		"max": max_value,
		"step": step,
		"history": value_history
	}

func reset_value():
	set_spin_value(0.0)

func reset_change_count():
	change_count = 0

func clear_history():
	value_history.clear()

func set_value_range(min_val: float, max_val: float):
	min_value = min_val
	max_value = max_val

func animate_to_value(target: float, duration: float):
	var tween = create_tween()
	tween.tween_method(set_spin_value, spin_value, target, duration)

func get_average_value():
	if value_history.size() == 0:
		return 0.0
	var sum = 0.0
	for entry in value_history:
		sum += entry["value"]
	return sum / value_history.size()
