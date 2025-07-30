extends HTTPRequest

var request_data = {}
var response_count = 0
var timeout_duration = 30.0

func _ready():
	timeout = timeout_duration
	connect("request_completed", _on_request_completed)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	response_count += 1
	print("Request completed: ", response_code, " (Count: ", response_count, ")")

func make_dummy_request(url: String):
	request_data["url"] = url
	request_data["timestamp"] = Time.get_unix_time_from_system()
	request(url)

func set_timeout_duration(duration: float):
	timeout_duration = duration
	timeout = timeout_duration

func get_request_info():
	return {
		"data": request_data,
		"response_count": response_count,
		"timeout": timeout_duration,
		"status": get_http_client_status()
	}

func cancel_current_request():
	cancel_request()

func reset_response_count():
	response_count = 0

func add_header(name: String, value: String):
	request_data[name] = value

func simulate_request():
	response_count += 1
	print("Simulated request completed")

func is_request_active():
	return get_http_client_status() != HTTPClient.STATUS_DISCONNECTED
