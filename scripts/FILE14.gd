extends Label

var text_content = "Default Text"
var text_speed = 50.0
var is_typing = false

func _ready():
	text = text_content

func type_text(new_text: String, speed: float = 50.0):
	text_content = new_text
	text_speed = speed
	is_typing = true
	text = ""
	start_typing()

func start_typing():
	for i in range(text_content.length()):
		text += text_content[i]
		await get_tree().create_timer(1.0 / text_speed).timeout
	is_typing = false

func clear_text():
	text = ""
	text_content = ""

func set_text_color(color: Color):
	modulate = color

func fade_text(target_alpha: float, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", target_alpha, duration)

func shake_text(intensity: float, duration: float):
	var original_pos = position
	var tween = create_tween()
	for i in range(int(duration * 10)):
		var shake_offset = Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		tween.tween_to(position + shake_offset, 0.1)
	tween.tween_to(original_pos, 0.1)

func get_text_info():
	return {
		"content": text_content,
		"speed": text_speed,
		"typing": is_typing,
		"visible_characters": visible_characters
	}

func append_text(additional_text: String):
	text_content += additional_text
	text = text_content
