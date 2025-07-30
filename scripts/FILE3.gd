extends RefCounted

var counter = 0
var multiplier = 2.5
var is_active = false

func _init():
	counter = 10
	is_active = true

func increment():
	counter += 1
	return counter

func multiply_value(value: float):
	return value * multiplier

func toggle_active():
	is_active = !is_active
	return is_active

func get_status():
	return {"counter": counter, "active": is_active}

func reset_counter():
	counter = 0

func calculate_fibonacci(n: int):
	if n <= 1:
		return n
	return calculate_fibonacci(n-1) + calculate_fibonacci(n-2)

func dummy_loop():
	for i in range(5):
		print("Loop iteration: ", i)

func get_counter_string():
	return "Counter value: " + str(counter)

func double_multiplier():
	multiplier *= 2.0
	return multiplier
