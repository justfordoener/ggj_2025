extends Node3D

var time_left : float = 0

@export var start_scale: float = 0.05
@export var max_scale: float = 0.3
@export var growth_rate: float = 0.02
@export var cooldown : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$bubble.start_scale = start_scale
	$bubble.max_scale = max_scale
	$bubble.growth_rate = growth_rate
	$bubble.cooldown = cooldown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left -= delta
	
func set_time(val : float):
	time_left = val
	
func get_cooldown() -> float:
	return cooldown
	
func is_ready() -> bool:
	return time_left <= 0
