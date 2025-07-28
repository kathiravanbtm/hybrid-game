extends ItemList

var items_data = []
var selection_history = []

func _ready():
	setup_items()
	connect("item_selected", _on_item_selected)

func setup_items():
	for i in range(5):
		var item_data = {"text": "Item " + str(i + 1), "id": i, "selected": false}
		items_data.append(item_data)
		add_item(item_data["text"])
	item_count = items_data.size()

func _on_item_selected(index: int):
	selection_history.append({"index": index, "time": Time.get_unix_time_from_system()})
	update_selection_states(index)
	print("Item selected: ", index)

func update_selection_states(selected_index: int):
	for i in range(items_data.size()):
		items_data[i]["selected"] = (i == selected_index)

func add_list_item(text: String):
	var new_item = {"text": text, "id": items_data.size(), "selected": false}
	items_data.append(new_item)
	add_item(text)
	item_count += 1

func remove_list_item(index: int):
	if index >= 0 and index < items_data.size():
		items_data.remove_at(index)
		remove_item(index)
		item_count -= 1

func get_list_info():
	return {
		"items": items_data,
		"count": item_count,
		"selections": selection_history,
		"selected_index": get_selected_items()
	}

func clear_items():
	items_data.clear()
	clear()
	item_count = 0

func get_selected_item_data():
	var selected_indices = get_selected_items()
	if selected_indices.size() > 0:
		return items_data[selected_indices[0]]
	return null

func shuffle_items():
	items_data.shuffle()
	clear()
	for item in items_data:
		add_item(item["text"])
