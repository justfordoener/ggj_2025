extends Node3D

var out_top: float = -3
var out_bottom: float = 5
var out_left: float = -5
var out_right: float = 6
var y_level: float = 2.5


var movement_speed = 2
var target_position: Vector3 = Vector3(out_top, y_level, out_left) # Should be start position at init
var start_rotation: Vector3 = Vector3(-45, 0, 0)
var swim_timer: float = 0


func _random_out_position() -> Vector3:
	var is_x_fixed = randi() % 2 == 0
	var x = 0
	var z = 0

	if is_x_fixed:
		x = out_left if randf() < 0.5 else out_right
		z = lerp(out_top + 2, out_bottom - 2, randf())
	else:
		x = lerp(out_left + 2, out_right - 2, randf())
		z = out_bottom if randf() < 0.5 else out_top

	# Check if the current position already has the same fixed x or z
	if (global_position.x == x or global_position.z == z):
		return _random_out_position() # Recursively call to find new coordinates

	return Vector3(x, global_position.y, z)


func _ready() -> void:
	global_position = target_position
	global_rotation_degrees = start_rotation
	await get_tree().create_timer(5)
	run()

func _process(delta: float):
	if global_position.distance_to(target_position) > 0.1: # Tolerance to stop moving near target
		var direction = (target_position - global_position).normalized()
		global_position += direction * movement_speed * delta

		# Update rotation to face the movement direction
		look_at(global_position + direction, Vector3.UP)

	# Rotate to align the correct axis (if the model's forward is not +Z)
		rotate_y(deg_to_rad(-90)) # Adjust this based on your model's forward direction
	else:
	# Snap to target position and stop
		global_position = target_position
		target_position = _random_out_position()

func run():
	target_position = _random_out_position()
