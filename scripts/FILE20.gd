extends ParallaxBackground

var parallax_layers = []
var scroll_speed = Vector2(50, 0)
var auto_scroll = false

func _ready():
	setup_parallax_layers()

func _process(delta):
	if auto_scroll:
		scroll_offset += scroll_speed * delta

func setup_parallax_layers():
	for i in range(3):
		var layer_data = {"id": i, "speed": (i + 1) * 0.5, "enabled": true}
		parallax_layers.append(layer_data)

func set_scroll_speed(speed: Vector2):
	scroll_speed = speed

func toggle_auto_scroll():
	auto_scroll = !auto_scroll

func get_parallax_info():
	return {
		"layers": parallax_layers,
		"scroll_speed": scroll_speed,
		"auto_scroll": auto_scroll,
		"scroll_offset": scroll_offset
	}

func reset_scroll():
	scroll_offset = Vector2.ZERO

func add_parallax_layer(layer_speed: float):
	var new_layer = {"id": parallax_layers.size(), "speed": layer_speed, "enabled": true}
	parallax_layers.append(new_layer)

func remove_parallax_layer(layer_id: int):
	for i in range(parallax_layers.size()):
		if parallax_layers[i]["id"] == layer_id:
			parallax_layers.remove_at(i)
			break

func update_layer_speed(layer_id: int, new_speed: float):
	for layer in parallax_layers:
		if layer["id"] == layer_id:
			layer["speed"] = new_speed
			break

func animate_scroll_to(target_offset: Vector2, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "scroll_offset", target_offset, duration)
