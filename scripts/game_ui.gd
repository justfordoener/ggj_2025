extends Control

@onready var game_over_menu = $"game over menu"
@onready var game_timer = $"game timer"
@onready var game_running = true
@onready var spiders_node
@onready var alive_spiders = []
@export var coop : bool = true

@export_file("*.tscn") var main_menu_path : String

func _ready():
	var level = get_parent()
	spiders_node = level.get_node("spiders")
	
	
	if not coop:
		game_timer.visible = false
		
	game_over_menu.visible = false
	game_running = true
	
	game_timer.connect("ambulance_is_there", Callable(self, "_on_ambulance_is_there"))
	
	if spiders_node:
		for spider in spiders_node.get_children():
			if spider.has_signal("spider_died"):
				spider.connect("spider_died", Callable(self, "_on_spider_died"))
				alive_spiders.append(spider)
	else:
		print("Spiders node not found!")

func start_game(coop_mode : bool):
	print("game ui starts scene now!")
	coop = coop_mode
	if not coop:
		game_timer.visible = false
	
func _process(delta):
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
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
		if coop:
			_set_game_finished()
			var text = "Game Over.. Your friend " + name + " suffocated.."
			game_over_menu.set_text(text)
		else: # competitive
			var i_to_delete = null
			for i in range(len(alive_spiders)):
				if alive_spiders[i].spider_name == name:
					i_to_delete = i
			alive_spiders.remove_at(i_to_delete)
			if len(alive_spiders) == 1:
				_set_game_finished()
				var text = alive_spiders[0].spider_name + " survived longer than everyone!\nHe gets the air-ambulance all for himself!"
				game_over_menu.set_text(text)

func _on_ambulance_is_there():
	if game_running:
		print("UI received signal: Timer is finished!")
		_set_game_finished()
		var text = "Game Won!! The Air-ambulance saved everyone!!"
		game_over_menu.set_text(text)
		

func _set_game_finished():
	$AudioStreamPlayer.stop()
	game_running = false
	game_over_menu.visible = true
	for spider in spiders_node.get_children():
		pass#spider.set_game_running(game_running)
