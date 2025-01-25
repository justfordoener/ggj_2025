extends Node3D

var time_left : float = 0

@onready var cooldown : float = $bubble.cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left -= delta
	
func set_time(val : float):
	time_left = val
	
func get_cooldown() -> float:
	return cooldown
	
func is_ready() -> bool:
	return time_left <= 0
