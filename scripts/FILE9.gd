extends RigidBody2D

var velocity_data = Vector2.ZERO
var angular_velocity_data = 0.0
var mass_value = 1.0

func _ready():
	mass = mass_value
	gravity_scale = 1.0

func apply_force_dummy(force: Vector2):
	apply_central_force(force)
	velocity_data = linear_velocity

func apply_torque_dummy(torque: float):
	apply_torque(torque)
	angular_velocity_data = angular_velocity

func get_motion_data():
	return {
		"velocity": velocity_data,
		"angular_velocity": angular_velocity_data,
		"mass": mass_value
	}

func set_mass_value(new_mass: float):
	mass_value = new_mass
	mass = mass_value

func stop_motion():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	velocity_data = Vector2.ZERO
	angular_velocity_data = 0.0

func add_random_impulse():
	var random_impulse = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	apply_central_impulse(random_impulse)

func calculate_kinetic_energy():
	return 0.5 * mass * velocity_data.length_squared()

func is_moving():
	return velocity_data.length() > 0.1
