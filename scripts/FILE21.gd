extends FileDialog

var selected_files = []
var file_filters = ["*.txt", "*.json", "*.cfg"]
var current_directory = ""

func _ready():
	file_mode = FileDialog.FILE_MODE_OPEN_FILE
	access = FileDialog.ACCESS_FILESYSTEM
	connect("file_selected", _on_file_selected)
	connect("files_selected", _on_files_selected)

func _on_file_selected(path: String):
	selected_files.append(path)
	print("File selected: ", path)

func _on_files_selected(paths: PackedStringArray):
	for path in paths:
		selected_files.append(path)
	print("Files selected: ", paths.size())

func set_file_filters(filters: Array):
	file_filters = filters
	clear_filters()
	for filter in filters:
		add_filter(filter)

func get_dialog_info():
	return {
		"selected_files": selected_files,
		"filters": file_filters,
		"current_dir": current_directory,
		"mode": file_mode
	}

func clear_selected_files():
	selected_files.clear()

func set_current_directory(dir_path: String):
	current_directory = dir_path
	current_dir = dir_path

func open_file_dialog():
	popup_centered_ratio(0.6)

func save_file_dialog():
	file_mode = FileDialog.FILE_MODE_SAVE_FILE
	popup_centered_ratio(0.6)

func get_last_selected_file():
	if selected_files.size() > 0:
		return selected_files[-1]
	return ""
