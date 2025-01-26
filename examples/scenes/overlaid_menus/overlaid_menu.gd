extends OverlaidMenu

@export_file("*.tscn") var main_menu_path : String

@onready var displayText : Label = $MenuPanelContainer/MarginContainer/BoxContainer/TitleMargin/TitleLabel
@onready var game_running = false

func _ready():
	pass
	
func _process(delta):
	if not game_running:
		if Input.is_action_pressed("1_move_up"):
			if Input.is_action_pressed("2_move_up"):
				if Input.is_action_pressed("3_move_up"):
					if Input.is_action_pressed("4_move_up"):
						_restart_game()

func _on_restart_button_pressed():
	_restart_game()
func _on_main_menu_button_pressed():
	SceneLoader.load_scene(main_menu_path)
	
func _restart_game():
	SceneLoader.reload_current_scene()

	
func set_text_loss(dead_spider):
	displayText.text = "Game Over.. Your friend " + dead_spider + " suffocated.."

func set_text_win():
	displayText.text = "Game Won!! The Air-ambulance saved everyone!!"
