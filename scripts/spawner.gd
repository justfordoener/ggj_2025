extends Node3D

@export var starting_time : int

@onready var bubble = preload(r"res://scenes/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	for point in $"spawn_points".get_children():
		starting_time = randi_range(0, 10)
		point.set_time(starting_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for point in $"spawn_points".get_children():
		if point.is_ready():
			print("spawned")
			_spawn_bubble(point)

func _spawn_bubble(point : Node3D):
	var instance = bubble.instantiate()
	instance.position = point.position
	add_child(instance)
	point.set_time(point.get_cooldown())
