extends TextEdit

var document_text = ""
var edit_history = []
var word_count = 0

func _ready():
	text = document_text
	connect("text_changed", _on_text_changed)

func _on_text_changed():
	document_text = text
	word_count = count_words()
	edit_history.append({"length": document_text.length(), "time": Time.get_unix_time_from_system()})

func count_words():
	var words = document_text.split(" ")
	var count = 0
	for word in words:
		if word.strip_edges() != "":
			count += 1
	return count

func count_lines():
	return document_text.split("\n").size()

func get_document_info():
	return {
		"text": document_text,
		"word_count": word_count,
		"line_count": count_lines(),
		"character_count": document_text.length(),
		"edits": edit_history.size()
	}

func append_text(new_text: String):
	document_text += new_text
	text = document_text

func prepend_text(new_text: String):
	document_text = new_text + document_text
	text = document_text

func clear_document():
	document_text = ""
	text = document_text

func insert_at_cursor(insert_text: String):
	var cursor_pos = get_caret_column()
	var line_num = get_caret_line()
	insert_text_at_caret(insert_text)

func get_selected_text_info():
	return {
		"has_selection": has_selection(),
		"selected_text": get_selected_text() if has_selection() else ""
	}

func save_to_history():
	edit_history.append({"text": document_text, "time": Time.get_unix_time_from_system()})
