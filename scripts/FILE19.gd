extends Line2D

var line_points = []
var line_width_data = 5.0
var line_color_data = Color.RED

func _ready():
	width = line_width_data
	default_color = line_color_data

func add_line_point(point: Vector2):
	line_points.append(point)
	add_point(point)

func remove_last_point():
	if line_points.size() > 0:
		line_points.pop_back()
		if get_point_count() > 0:
			remove_point(get_point_count() - 1)

func clear_line():
	line_points.clear()
	clear_points()

func set_line_width(new_width: float):
	line_width_data = new_width
	width = line_width_data

func set_line_color(new_color: Color):
	line_color_data = new_color
	default_color = line_color_data

func get_line_info():
	return {
		"points": line_points,
		"width": line_width_data,
		"color": line_color_data,
		"point_count": get_point_count()
	}

func draw_circle_line(center: Vector2, radius: float, segments: int = 32):
	clear_line()
	for i in range(segments + 1):
		var angle = (i * 2 * PI) / segments
		var point = center + Vector2(cos(angle), sin(angle)) * radius
		add_line_point(point)

func animate_line_growth():
	for point in line_points:
		add_point(point)
		await get_tree().create_timer(0.1).timeout
