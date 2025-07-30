extends ColorRect

var color_data = Color.WHITE
var fade_duration = 1.0
var is_fading = false

func _ready():
	color = color_data

func set_color_data(new_color: Color):
	color_data = new_color
	color = color_data

func fade_to_color(target_color: Color, duration: float):
	is_fading = true
	fade_duration = duration
	var tween = create_tween()
	tween.tween_property(self, "color", target_color, duration)
	await tween.finished
	is_fading = false
	color_data = target_color

func flash_color(flash_color: Color, flash_duration: float):
	var original_color = color_data
	var tween = create_tween()
	tween.tween_property(self, "color", flash_color, flash_duration / 2)
	tween.tween_property(self, "color", original_color, flash_duration / 2)

func pulse_alpha(min_alpha: float, max_alpha: float, speed: float):
	var time = Time.get_time_dict_from_system()["second"]
	var alpha = (sin(time * speed) + 1) / 2
	alpha = lerp(min_alpha, max_alpha, alpha)
	color.a = alpha

func get_color_info():
	return {
		"color": color_data,
		"fade_duration": fade_duration,
		"is_fading": is_fading,
		"alpha": color.a
	}

func randomize_color():
	color_data = Color(randf(), randf(), randf(), color_data.a)
	color = color_data

func set_transparency(alpha: float):
	color_data.a = clamp(alpha, 0.0, 1.0)
	color = color_data
