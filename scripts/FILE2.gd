extends Node

var random_number = 42
var string_data = "dummy_file_2"
var array_data = [1, 2, 3, 4, 5]

func _ready():
	print("FILE2 loaded")
	calculate_random()

func calculate_random():
	var result = 0
	for i in range(10):
		result += randi() % 100
	return result

func get_dummy_data():
	return {"name": "file2", "value": random_number}

func process_array():
	var sum = 0
	for item in array_data:
		sum += item
	return sum

func dummy_function():
	var temp = "Hello World"
	temp = temp.to_upper()
	return temp.length()

func _exit_tree():
	print("FILE2 cleanup")

func shuffle_array():
	array_data.shuffle()
	return array_data

func get_random_string():
	var chars = "abcdefghijklmnopqrstuvwxyz"
	var result = ""
	for i in range(8):
		result += chars[randi() % chars.length()]
	return result
