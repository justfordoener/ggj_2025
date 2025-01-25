extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Load texture to Plane
	var image = load("res://textures/water_selfmade.png")
	var mesh = $plane
	var material_one = StandardMaterial3D.new()
	material_one.albedo_texture = image
	mesh.set_surface_override_material(0, material_one)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
