extends Node3D

# characteristics
@export var growth_rate: float = 0.5
@export var max_scale: float = 3.0
var air_amount: float = 0.0

# signal for popping
signal bubble_popped

func _ready():
	scale = Vector3(1,1,1)			# small starting bubble
	
func _process(delta: float):
	# bubble grows
	scale += Vector3.ONE * growth_rate * delta
	air_amount = calculate_air_amount(scale)
	
	# check if bubble popps
	if scale >= Vector3.ONE * max_scale:
		pop_bubble()

func calculate_air_amount(cur_scale: Vector3):
	return 4.0 / 3.0 * PI * pow(cur_scale.x, 3)

func pop_bubble():
	# emitt signal and play pop animation
	emit_signal("bubble_popped")
	print("Bubble popped")
	
	queue_free()
