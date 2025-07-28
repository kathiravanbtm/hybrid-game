extends OptionButton

var selected_option = 0
var options_list = ["Option 1", "Option 2", "Option 3"]
var selection_count = 0

func _ready():
	setup_options()
	connect("item_selected", _on_item_selected)

func setup_options():
	clear()
	for option in options_list:
		add_item(option)
	selected = selected_option

func _on_item_selected(index: int):
	selected_option = index
	selection_count += 1
	print("Option selected: ", options_list[index], " (Count: ", selection_count, ")")

func add_option(option_text: String):
	options_list.append(option_text)
	add_item(option_text)

func remove_option(index: int):
	if index >= 0 and index < options_list.size():
		options_list.remove_at(index)
		remove_item(index)

func get_option_info():
	return {
		"selected": selected_option,
		"options": options_list,
		"selections": selection_count,
		"current_text": get_item_text(selected_option) if selected_option < get_item_count() else ""
	}

func set_selected_option(index: int):
	if index >= 0 and index < options_list.size():
		selected_option = index
		selected = index

func clear_options():
	options_list.clear()
	clear()

func reset_selection_count():
	selection_count = 0

func get_selected_text():
	if selected_option < options_list.size():
		return options_list[selected_option]
	return ""

func shuffle_options():
	options_list.shuffle()
	setup_options()

func find_option(text: String):
	return options_list.find(text)
