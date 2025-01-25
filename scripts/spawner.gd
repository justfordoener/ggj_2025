extends Node3D


@onready var bubble = preload(r"res://scenes/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
