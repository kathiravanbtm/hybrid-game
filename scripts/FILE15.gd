extends Button

signal button_clicked_custom
signal button_state_changed

var click_count = 0
var button_state = "normal"
var custom_data = {}

func _ready():
	connect("pressed", _on_button_pressed)
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_button_pressed():
	click_count += 1
	emit_signal("button_clicked_custom", click_count)
	print("Button clicked: ", click_count, " times")

func _on_mouse_entered():
	button_state = "hover"
	emit_signal("button_state_changed", button_state)

func _on_mouse_exited():
	button_state = "normal"
	emit_signal("button_state_changed", button_state)

func reset_click_count():
	click_count = 0

func set_button_text(new_text: String):
	text = new_text

func get_button_info():
	return {
		"clicks": click_count,
		"state": button_state,
		"text": text,
		"disabled": disabled
	}

func toggle_button():
	disabled = !disabled

func set_custom_data(key: String, value):
	custom_data[key] = value

func get_custom_data(key: String):
	return custom_data.get(key, null)

func animate_button():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
