extends Node3D

@export var speed = 0.1
@export var rotation_speed = 1
var orientation : Vector3 = Vector3(1,0,0)
var direction : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	
func _move(delta : float):
	direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction += Vector3(1,0,0)		
	if Input.is_action_pressed("move_left"):
		direction -= Vector3(1,0,0)
	if Input.is_action_pressed("move_up"):
		direction -= Vector3(0,0,1)
	if Input.is_action_pressed("move_down"):
		direction += Vector3(0,0,1)	
	position += direction * speed * delta
	look_at(global_position + direction, Vector3.UP)
