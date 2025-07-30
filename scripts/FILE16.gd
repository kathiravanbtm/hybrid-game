extends AnimationPlayer

var animation_speed = 1.0       
var loop_count = 0

func _ready():
	connect("animation_finished", _on_animation_finished)
	speed_scale = animation_speed

func _on_animation_finished(anim_name: String):
	loop_count += 1
	print("Animation finished: ", anim_name, " (Loop: ", loop_count, ")")

func play_animation(anim_name: String, speed: float = 1.0):
	current_animation = anim_name
	animation_speed = speed
	speed_scale = speed
	if has_animation(anim_name):
		play(anim_name)

func set_animation_speed(speed: float):
	animation_speed = speed
	speed_scale = speed

func get_animation_info():
	return {
		"current": current_animation,
		"speed": animation_speed,
		"loops": loop_count,
		"playing": is_playing(),
		"position": current_animation_position
	}

func reset_loop_count():
	loop_count = 0

func pause_animation():
	pause()

func resume_animation():
	play()

func stop_animation():
	stop()
	current_animation = ""

func seek_to_position(position: float):
	seek(position)

func get_animation_length(anim_name: String):
	if has_animation(anim_name):
		return get_animation(anim_name).length
	return 0.0
