extends Area2D

signal dummy_signal_triggered
signal area_activated

var area_size = Vector2(100, 100)
var is_monitoring = true
var detection_count = 0

func _ready():
	monitoring = is_monitoring
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	detection_count += 1
	emit_signal("dummy_signal_triggered", body)

func _on_body_exited(body):
	print("Body exited area: ", body.name)

func toggle_monitoring():
	is_monitoring = !is_monitoring
	monitoring = is_monitoring

func get_detection_stats():
	return {
		"count": detection_count,
		"monitoring": is_monitoring,
		"size": area_size
	}

func resize_area(new_size: Vector2):
	area_size = new_size

func activate_area():
	emit_signal("area_activated")
	is_monitoring = true
	monitoring = true

func deactivate_area():
	is_monitoring = false
	monitoring = false

func reset_detection_count():
	detection_count = 0

func get_area_bounds():
	return Rect2(position - area_size/2, area_size)
