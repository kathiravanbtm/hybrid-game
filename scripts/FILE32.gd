extends Tree

var tree_data = {}
var expanded_count = 0
var selected_item = null

func _ready():
	setup_tree()
	connect("item_selected", _on_item_selected)

func setup_tree():
	clear()
	var root = create_item()
	root.set_text(0, "Root")
	tree_data["root"] = {"text": "Root", "children": []}
	
	for i in range(3):
		var child = create_item(root)
		child.set_text(0, "Child " + str(i + 1))
		tree_data["root"]["children"].append({"text": "Child " + str(i + 1), "expanded": false})

func _on_item_selected():
	selected_item = get_selected()
	if selected_item:
		print("Tree item selected: ", selected_item.get_text(0))

func expand_all_items():
	var root = get_root()
	if root:
		expand_recursive(root)

func expand_recursive(item: TreeItem):
	item.set_collapsed(false)
	expanded_count += 1
	var child = item.get_first_child()
	while child:
		expand_recursive(child)
		child = child.get_next()

func collapse_all_items():
	var root = get_root()
	if root:
		collapse_recursive(root)

func collapse_recursive(item: TreeItem):
	item.set_collapsed(true)
	var child = item.get_first_child()
	while child:
		collapse_recursive(child)
		child = child.get_next()

func get_tree_info():
	return {
		"data": tree_data,
		"expanded_count": expanded_count,
		"has_selection": selected_item != null
	}

func add_child_item(parent_text: String, child_text: String):
	var item = find_item_by_text(parent_text)
	if item:
		var child = create_item(item)
		child.set_text(0, child_text)

func find_item_by_text(text: String):
	return search_tree_recursive(get_root(), text)

func search_tree_recursive(item: TreeItem, text: String):
	if item and item.get_text(0) == text:
		return item
	var child = item.get_first_child() if item else null
	while child:
		var result = search_tree_recursive(child, text)
		if result:
			return result
		child = child.get_next()
	return null
