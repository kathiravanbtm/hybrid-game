extends LineEdit

var text_data = ""
var input_history = []
var max_history = 10

func _ready():
	text = text_data
	connect("text_changed", _on_text_changed)
	connect("text_submitted", _on_text_submitted)

func _on_text_changed(new_text: String):
	text_data = new_text

func _on_text_submitted(submitted_text: String):
	input_history.append({"text": submitted_text, "time": Time.get_unix_time_from_system()})
	if input_history.size() > max_history:
		input_history.pop_front()
	print("Text submitted: ", submitted_text)

func set_text_data(new_text: String):
	text_data = new_text
	text = text_data

func clear_input():
	set_text_data("")

func get_input_info():
	return {
		"current_text": text_data,
		"history": input_history,
		"max_length": max_length,
		"editable": editable
	}

func add_to_text(additional_text: String):
	set_text_data(text_data + additional_text)

func get_last_input():
	if input_history.size() > 0:
		return input_history[-1]["text"]
	return ""

func set_placeholder_text(placeholder: String):
	placeholder_text = placeholder

func validate_input():
	return text_data.length() > 0 and not text_data.begins_with(" ")

func focus_input():
	grab_focus()

func clear_history():
	input_history.clear()

func count_words():
	return text_data.split(" ").size() if text_data != "" else 0
