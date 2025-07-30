extends CheckBox

var is_checked_data = false
var check_count = 0
var toggle_history = []

func _ready():
	button_pressed = is_checked_data
	connect("toggled", _on_toggled)

func _on_toggled(pressed: bool):
	is_checked_data = pressed
	check_count += 1
	toggle_history.append({"checked": pressed, "time": Time.get_unix_time_from_system()})
	print("Checkbox toggled: ", pressed, " (Count: ", check_count, ")")

func set_checked(checked: bool):
	is_checked_data = checked
	button_pressed = checked

func get_checkbox_info():
	return {
		"checked": is_checked_data,
		"count": check_count,
		"history": toggle_history,
		"disabled": disabled
	}

func reset_check_count():
	check_count = 0

func clear_history():
	toggle_history.clear()

func toggle_checkbox():
	set_checked(!is_checked_data)

func animate_checkbox():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func get_last_toggle_time():
	if toggle_history.size() > 0:
		return toggle_history[-1]["time"]
	return 0

func is_recently_toggled(seconds: float):
	var last_time = get_last_toggle_time()
	return Time.get_unix_time_from_system() - last_time < seconds

func enable_checkbox():
	disabled = false

func disable_checkbox():
	disabled = true
