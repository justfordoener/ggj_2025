extends MainMenu

var animation_state_machine : AnimationNodeStateMachinePlayback

@export_file("*.tscn") var level_1_scene_path : String
@export_file("*.tscn") var level_2_scene_path : String

func intro_done():
	animation_state_machine.travel("OpenMainMenu")

func _is_in_intro():
	return animation_state_machine.get_current_node() == "Intro"

func _event_is_mouse_button_released(event : InputEvent):
	return event is InputEventMouseButton and not event.is_pressed()

func _event_skips_intro(event : InputEvent):
	return event.is_action_released("ui_accept") or \
		event.is_action_released("ui_select") or \
		event.is_action_released("ui_cancel") or \
		_event_is_mouse_button_released(event)

func _open_sub_menu(menu):
	super._open_sub_menu(menu)
	animation_state_machine.travel("OpenSubMenu")

func _close_sub_menu():
	super._close_sub_menu()
	animation_state_machine.travel("OpenMainMenu")

func _input(event):
	if _is_in_intro() and _event_skips_intro(event):
		intro_done()
		return
	super._input(event)

func _ready():
	super._ready()
	animation_state_machine = $MenuAnimationTree.get("parameters/playback")

func _on_continue_game_button_pressed():
	load_game_scene()
	
func _load_game_with_options(level = 1, coop = true):
	var path = null
	if level == 1:
		path = level_1_scene_path
	elif level == 2:
		path = level_2_scene_path
	print("loading new game with options: level: " + str(level) + " coop: " + str(coop))
	var loaded_scene = load(path).instantiate()
	get_tree().root.add_child(loaded_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = loaded_scene

	var game_ui = loaded_scene.find_child("Game UI", false, false)
	game_ui.start_game(coop)
	
	#load_game_scene()

func _on_new_game_button_pressed():
	pass

func _on_coop_1_pressed():
	_load_game_with_options(1, true)


func _on_pvp_1_pressed():
	_load_game_with_options(1, false)


func _on_coop_2_pressed():
	_load_game_with_options(2, true)


func _on_pvp_2_pressed():
	_load_game_with_options(2, false)
