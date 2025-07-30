extends TabContainer

var tab_data = []
var active_tab = 0
var tab_switch_count = 0

func _ready():
	setup_tabs()
	connect("tab_changed", _on_tab_changed)

func setup_tabs():
	for i in range(3):
		var tab_info = {"name": "Tab " + str(i + 1), "content": "Content " + str(i + 1), "active": i == 0}
		tab_data.append(tab_info)

func _on_tab_changed(tab: int):
	active_tab = tab
	tab_switch_count += 1
	update_tab_states()
	print("Tab changed to: ", tab, " (Switch count: ", tab_switch_count, ")")

func update_tab_states():
	for i in range(tab_data.size()):
		tab_data[i]["active"] = (i == active_tab)

func add_tab_data(name: String, content: String):
	var new_tab = {"name": name, "content": content, "active": false}
	tab_data.append(new_tab)

func remove_tab_data(index: int):
	if index >= 0 and index < tab_data.size():
		tab_data.remove_at(index)

func get_tab_info():
	return {
		"active": active_tab,
		"tabs": tab_data,
		"switch_count": tab_switch_count,
		"total_tabs": get_tab_count()
	}

func set_active_tab(index: int):
	if index >= 0 and index < get_tab_count():
		current_tab = index
		active_tab = index

func reset_switch_count():
	tab_switch_count = 0

func get_active_tab_name():
	if active_tab < tab_data.size():
		return tab_data[active_tab]["name"]
	return ""

func cycle_tabs():
	var next_tab = (active_tab + 1) % get_tab_count()
	set_active_tab(next_tab)
