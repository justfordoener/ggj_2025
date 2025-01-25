"""Spider 3 - (Wise William)"""

extends CharacterBody3D

@export var speed = 1
@export var rotation_speed = 1
@export var look_around_speed = 0.5
@export var lose_air_rate = 0.7
@export var player_num : String = "1"
@export var spider_name = "unnamed spider"
@export var color : Color

@onready var spider_mesh = $Area3D/CollisionShape3D2/geo_spider_low
@onready var breath : Node3D = $breath
@onready var own_area : Area3D = $Area3D
@onready var anim_player : AnimationPlayer = breath.get_child(0)

var orientation : Vector3 = Vector3(1,0,0)
var direction : Vector3 = Vector3.ZERO
var air : float = 10
var max_air : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("Air")
	# Spider has team color
	var material_spider = (spider_mesh.get_active_material(0)).duplicate()
	material_spider.albedo_color = color
	spider_mesh.set_surface_override_material(0, material_spider)
	# spider_bubble white
	var material_bubble = StandardMaterial3D.new()
	material_bubble.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material_bubble.albedo_color = Color(1, 1, 1, 0.3)
	#1$breath/bubble.set_surface_override_material(0, material_bubble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	_lose_air(delta)
	

func _move(delta : float):
	
	var dir = Vector3()
	dir.x = Input.get_axis(player_num + "_move_left", player_num + "_move_right")
	dir.z = Input.get_axis(player_num + "_move_up", player_num + "_move_down")

	# Limit the input to a length of 1. length_squared is faster to check.
	if dir.length_squared() > 1:
		dir /= dir.length()
	
	direction = Vector3.ZERO
	if Input.is_action_pressed(player_num + "_move_right"):
		direction += Vector3(1,0,0)		
	if Input.is_action_pressed(player_num + "_move_left"):
		direction -= Vector3(1,0,0)
	if Input.is_action_pressed(player_num + "_move_up"):
		direction -= Vector3(0,0,1)
	if Input.is_action_pressed(player_num + "_move_down"):
		direction += Vector3(0,0,1)	
	#position += direction * speed * delta
	if direction != Vector3.ZERO:
		look_at(global_position + direction, Vector3.UP)
		velocity = direction * speed
	else: 
		velocity = Vector3.ZERO
	#rotate_object_local(Vector3(0,1,0), delta * look_around_speed)
	move_and_slide()
	
func add_air(value : float):
	air += value
	if air > 10:
		air = 10
	
func _lose_air(delta : float):
	air -= lose_air_rate * delta
	if air <= 0:
		queue_free()
		print(spider_name + " di(e)d!")
	anim_player.seek(11 - air, true) 
	if air < 5:
		breath.scale = Vector3(air, air, air)
	else:
		breath.scale = Vector3(5, 5, 5)

func _on_area_entered(area: Area3D) -> void:
	if area.collision_layer & 4:
		var collided_bubble = area.get_parent()
		var new_air = collided_bubble.absorb_bubble()
		print(spider_name + " absorbed a bubble.")
		add_air(new_air)
