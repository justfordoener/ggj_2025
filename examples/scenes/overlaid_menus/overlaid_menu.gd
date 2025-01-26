extends OverlaidMenu

@onready var displayText : Label = $MenuPanelContainer/MarginContainer/BoxContainer/TitleMargin/TitleLabel
@onready var game_ui

func _ready():
	game_ui = get_parent()
	
func _process(delta):
	pass

func _on_restart_button_pressed():
	game_ui.restart_game()
	
func _on_main_menu_button_pressed():
	game_ui.load_main_menu()
	
func set_text(text):
	displayText.text = text
