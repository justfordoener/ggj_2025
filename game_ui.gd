extends Control

@onready var game_over_menu = $"game over menu"

func _ready():
	var level = get_parent()
	var spiders_node = level.get_node("spiders")
	
	game_over_menu.visible = false
	
	if spiders_node:
		for spider in spiders_node.get_children():
			if spider.has_signal("spider_died"):
				spider.connect("spider_died", Callable(self, "_on_spider_died"))
	else:
		print("Spiders node not found!")

func _on_spider_died(name):
	print("UI received signal: Spider " + name + " died!")
	game_over_menu.visible = true
	game_over_menu._set_text(name)

func _on_game_timer_finished():
	print("UI received signal: Timer is finished!")
	
	game_over_menu.visible = true
	game_over_menu.set_text()
