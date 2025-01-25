extends OverlaidMenu

@export_file("*.tscn") var main_menu_path : String

@onready var displayText : Label = $MenuPanelContainer/MarginContainer/BoxContainer/TitleMargin/TitleLabel

func _on_restart_button_pressed():
	SceneLoader.reload_current_scene()

func _on_main_menu_button_pressed():
	SceneLoader.load_scene(main_menu_path)
	
func _set_text(dead_spider):
	if dead_spider:
		displayText.text = "Game Over.. Your friend " + dead_spider + " suffocated.."
	else:
		displayText.text = "Game Won!! The Air-ambulance saved everyone!!"
