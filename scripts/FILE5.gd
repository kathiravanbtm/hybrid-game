extends Resource

@export var resource_value: int = 100
@export var resource_enabled: bool = true

var internal_data = {}
var creation_time: float

func _init():
	creation_time = Time.get_time_dict_from_system()["hour"]
	setup_internal_data()

func setup_internal_data():
	internal_data["id"] = randi()
	internal_data["timestamp"] = Time.get_unix_time_from_system()
	internal_data["version"] = "1.0"

func get_resource_info():
	return {
		"name": resource_name,
		"value": resource_value,
		"enabled": resource_enabled,
		"created": creation_time
	}

func update_value(new_value: int):
	resource_value = new_value
	internal_data["last_update"] = Time.get_unix_time_from_system()

func validate_resource():
	return resource_name != "" and resource_value > 0

func duplicate_resource():
	var new_resource = duplicate()
	new_resource.resource_name += "_copy"
	return new_resource

func reset_resource():
	resource_value = 100
	resource_enabled = true
	internal_data.clear()
	setup_internal_data()
