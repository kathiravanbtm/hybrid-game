extends ScrollContainer

var scroll_data = Vector2.ZERO
var scroll_speed = 100.0
var auto_scroll_enabled = false

func _ready():
	scroll_horizontal = scroll_data.x
	scroll_vertical = scroll_data.y

func _process(delta):
	if auto_scroll_enabled:
		auto_scroll(delta)

func auto_scroll(delta):
	scroll_data.y += scroll_speed * delta
	scroll_vertical = scroll_data.y

func set_scroll_position(position: Vector2):
	scroll_data = position
	scroll_horizontal = position.x
	scroll_vertical = position.y

func smooth_scroll_to(target: Vector2, duration: float):
	var tween = create_tween()
	tween.tween_method(set_scroll_position, scroll_data, target, duration)

func toggle_auto_scroll():
	auto_scroll_enabled = !auto_scroll_enabled

func set_scroll_speed(speed: float):
	scroll_speed = speed

func get_scroll_info():
	return {
		"position": scroll_data,
		"speed": scroll_speed,
		"auto_scroll": auto_scroll_enabled,
		"max_scroll": Vector2(get_h_scroll_bar().max_value, get_v_scroll_bar().max_value)
	}

func scroll_to_top():
	set_scroll_position(Vector2(scroll_data.x, 0))

func scroll_to_bottom():
	var max_y = get_v_scroll_bar().max_value
	set_scroll_position(Vector2(scroll_data.x, max_y))

func scroll_to_left():
	set_scroll_position(Vector2(0, scroll_data.y))

func scroll_to_right():
	var max_x = get_h_scroll_bar().max_value
	set_scroll_position(Vector2(max_x, scroll_data.y))

func reset_scroll():
	set_scroll_position(Vector2.ZERO)

func is_at_bottom():
	return scroll_vertical >= get_v_scroll_bar().max_value - 10

func is_at_top():
	return scroll_vertical <= 10
