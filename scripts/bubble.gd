extends Node3D

# characteristics
@export var start_scale: float = 0.05
@export var max_scale: float = 0.3
@export var growth_rate: float = 0.02
@export var cooldown : float = 0
@export var time_to_pop : float = 10
@export var float_speed : float = 0.6
var air_amount: float = 0.0
var has_spawned : bool = false
var is_full : bool = false

@onready var timer : Timer = $Timer
#onready var collision_shape = $Area3D/CollisionShape3D

func _ready():
	timer.wait_time = time_to_pop 
	timer.one_shot = true
	scale = Vector3.ONE * start_scale			# small starting bubble
	await get_tree().create_timer(cooldown).timeout
	has_spawned = true
	# bubble style
	var bubble = $MeshInstance3D
	var material_bubble = StandardMaterial3D.new()
	material_bubble.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material_bubble.albedo_color = Color(1, 1, 1, 0.3)
	bubble.set_surface_override_material(0, material_bubble)

func _process(delta: float):
	if not has_spawned:
		return
	# bubble grows
	if not is_full:
		scale += Vector3.ONE * growth_rate * delta
		air_amount = calculate_air_amount(scale)
	
	# check if bubble popps
	if scale >= Vector3.ONE * max_scale:
		pop_bubble(delta)
		

func calculate_air_amount(cur_scale: Vector3):
	return 4.0 / 3.0 * PI * pow(cur_scale.x, 3) * 1000

func pop_bubble(delta : float):
	if not is_full:
		is_full = true
		timer.start()
	global_position += Vector3(0,1,0) * delta * float_speed	
func _on_timer_timeout():
	queue_free()
	
func absorb_bubble() -> float:
	var absorbed_air = air_amount
	# send signal that bubble is absorbed
	# emit_signal("bubble_absorbed", absorbed_air)
	# delete bubble
	queue_free()
	# return aborbed air
	print("absorbed " + str(absorbed_air) + " air")
	return absorbed_air
