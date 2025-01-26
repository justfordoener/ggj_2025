extends Control

@onready var game_over_menu = $"game over menu"
@onready var game_timer = $"game timer"
@onready var game_running = true

@export_file("*.tscn") var main_menu_path : String

func _ready():
	var level = get_parent()
	var spiders_node = level.get_node("spiders")
	
	game_over_menu.visible = false
	game_running = true
	
	game_timer.connect("ambulance_is_there", Callable(self, "_on_ambulance_is_there"))
	
	if spiders_node:
		for spider in spiders_node.get_children():
			if spider.has_signal("spider_died"):
				spider.connect("spider_died", Callable(self, "_on_spider_died"))
	else:
		print("Spiders node not found!")

func _process(delta):
	if not game_running:
		if Input.is_action_pressed("1_move_up"):
			if Input.is_action_pressed("2_move_up"):
				if Input.is_action_pressed("3_move_up"):
					if Input.is_action_pressed("4_move_up"):
						restart_game()

func restart_game():
	SceneLoader.reload_current_scene()
	
func load_main_menu():
	SceneLoader.load_scene(main_menu_path)

func _on_spider_died(name):
	print("UI received signal: Spider " + name + " died!")
	game_over_menu.visible = true
	game_over_menu.set_text_loss(name)
	game_running = false

func _on_ambulance_is_there():
	print("UI received signal: Timer is finished!")
	game_over_menu.visible = true
	game_over_menu.set_text_win()
	game_running = false
