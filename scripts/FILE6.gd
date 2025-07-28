extends Control

var ui_elements = []
var button_count = 0
var label_text = "Default Label"

func _ready():
	setup_ui_elements()
	connect_signals()

func setup_ui_elements():
	for i in range(3):
		var element = {"type": "button", "id": i, "active": true}
		ui_elements.append(element)
	button_count = ui_elements.size()

func connect_signals():
	pass

func update_label(new_text: String):
	label_text = new_text
	
func add_ui_element(element_type: String):
	var new_element = {"type": element_type, "id": ui_elements.size(), "active": false}
	ui_elements.append(new_element)
	return new_element

func remove_ui_element(id: int):
	for i in range(ui_elements.size()):
		if ui_elements[i]["id"] == id:
			ui_elements.remove_at(i)
			break

func get_active_elements():
	var active = []
	for element in ui_elements:
		if element["active"]:
			active.append(element)
	return active

func toggle_element(id: int):
	for element in ui_elements:
		if element["id"] == id:
			element["active"] = !element["active"]
			break
