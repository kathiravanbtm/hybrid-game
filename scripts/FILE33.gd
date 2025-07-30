extends GridContainer

var grid_items = []
var columns_count = 3
var items_added = 0

func _ready():
	columns = columns_count
	setup_grid_items()

func setup_grid_items():
	for i in range(9):
		var item_data = {"id": i, "position": Vector2(i % columns_count, i / columns_count), "active": true}
		grid_items.append(item_data)

func add_grid_item(item_node: Control):
	add_child(item_node)
	items_added += 1

func remove_grid_item(index: int):
	if index >= 0 and index < get_child_count():
		get_child(index).queue_free()

func set_columns_count(count: int):
	columns_count = count
	columns = count
	reorganize_grid()

func reorganize_grid():
	for i in range(grid_items.size()):
		grid_items[i]["position"] = Vector2(i % columns_count, i / columns_count)

func get_grid_info():
	return {
		"items": grid_items,
		"columns": columns_count,
		"rows": ceil(float(grid_items.size()) / columns_count),
		"items_added": items_added,
		"children_count": get_child_count()
	}

func clear_grid():
	for child in get_children():
		child.queue_free()
	grid_items.clear()

func get_item_at_position(grid_pos: Vector2):
	for item in grid_items:
		if item["position"] == grid_pos:
			return item
	return null

func toggle_item_active(index: int):
	if index >= 0 and index < grid_items.size():
		grid_items[index]["active"] = !grid_items[index]["active"]

func count_active_items():
	var count = 0
	for item in grid_items:
		if item["active"]:
			count += 1
	return count

func resize_grid(new_columns: int, new_rows: int):
	set_columns_count(new_columns)
	var target_items = new_columns * new_rows
	while grid_items.size() < target_items:
		var new_item = {"id": grid_items.size(), "position": Vector2.ZERO, "active": true}
		grid_items.append(new_item)
	reorganize_grid()
