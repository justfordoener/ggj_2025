extends Control

@onready var game_over_menu = $"game over menu"
@onready var game_timer = $"game timer"
@onready var game_running = true
@onready var spiders_node


@export_file("*.tscn") var main_menu_path : String

func _ready():
	var level = get_parent()
	spiders_node = level.get_node("spiders")
	
	game_over_menu.visible = false
	game_running = true
	
	game_timer.connect("ambulance_is_there", Callable(self, "_on_ambulance_is_there"))
	
	if spiders_node:
		for spider in spiders_node.get_children():
			if spider.has_signal("spider_died"):
				spider.connect("spider_died", Callable(self, "_on_spider_died"))
	else:
		print("Spiders node not found!")

func start_game():
	print("game ui starts scene now!")
	
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
	if game_running:
		print("UI received signal: Spider " + name + " died!")
		_set_game_finished()
		game_over_menu.set_text_loss(name)

func _on_ambulance_is_there():
	if game_running:
		print("UI received signal: Timer is finished!")
		_set_game_finished()
		game_over_menu.set_text_win()
		

func _set_game_finished():
	game_running = false
	game_over_menu.visible = true
	for spider in spiders_node.get_children():
		spider.set_game_running(game_running)
