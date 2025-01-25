extends Node3D

@export var wobble_speed: float = 1.0
@export var wobble_intensity: float = 0.1

var time: float = 0.0
var initial_position: Vector3
var initial_rotation: Vector3

func _ready():
	initial_position = get_parent().position
	initial_rotation = get_parent().rotation

func _process(delta):
	time += delta * wobble_speed
	
	var wobble_x = sin(time * 1.7) * cos(time * -1.2) * sin(time * 1.4) * wobble_intensity
	var wobble_y = cos(time * 2.3) * sin(time * -1.1) * cos(time * 1.0) * wobble_intensity
	var wobble_z = sin(time * 1.9) * cos(time * -1.9) * sin(time * 1.8) * wobble_intensity
	
	get_parent().position = initial_position + Vector3(wobble_x, wobble_y, wobble_z)
	get_parent().rotation = initial_rotation + Vector3(wobble_x, wobble_y, wobble_z) * 0.1
