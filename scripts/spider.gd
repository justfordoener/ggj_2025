extends Node3D

@export var speed = 0.5
@export var rotation_speed = 1
@export var look_around_speed = 0.5
@export var lose_air_rate = 5

@onready var bubble : Node3D = $breath
@onready var own_area : Area3D = $Area3D
var orientation : Vector3 = Vector3(1,0,0)
var direction : Vector3 = Vector3.ZERO
var air : float = 100
var max_air : float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	_lose_air(delta)
	
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
	if direction != Vector3.ZERO:
		look_at(global_position + direction, Vector3.UP)
	#rotate_object_local(Vector3(0,1,0), delta * look_around_speed)

func add_air(value : float):
	air += value
	
func _lose_air(delta : float):
	air -= lose_air_rate * delta
	if air <= 0:
		queue_free()
		print("you did it! you di(e)d!")
	bubble.scale = Vector3(air / max_air, air / max_air, air / max_air)
	
func _on_area_entered(area: Area3D) -> void:
	if area.collision_layer & 4:
		print("collision with bubble")
		var collided_bubble = area.get_parent()
		var new_air = collided_bubble.absorb_bubble()
		add_air(new_air)
	
