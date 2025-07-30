extends Timer

var timer_duration = 1.0
var timer_count = 0
var auto_restart = false

func _ready():
	wait_time = timer_duration
	connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	timer_count += 1
	print("Timer triggered: ", timer_count)
	if auto_restart:
		start()

func start_timer(duration: float = -1):
	if duration > 0:
		timer_duration = duration
		wait_time = timer_duration
	start()

func stop_timer():
	stop()

func reset_timer():
	timer_count = 0
	stop()

func set_auto_restart(enable: bool):
	auto_restart = enable

func get_timer_info():
	return {
		"duration": timer_duration,
		"count": timer_count,
		"auto_restart": auto_restart,
		"time_left": time_left,
		"is_stopped": is_stopped()
	}

func pause_timer():
	paused = true

func resume_timer():
	paused = false

func add_time(extra_time: float):
	wait_time += extra_time
