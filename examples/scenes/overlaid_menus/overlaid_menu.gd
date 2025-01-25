extends OverlaidMenu

@export_file("*.tscn") var game_scene_path : String
@export_file("*.tscn") var main_menu_path : String

func _on_restart_button_pressed():
	SceneLoader.reload_current_scene()

func _on_main_menu_button_pressed():
	SceneLoader.load_scene(main_menu_path)
