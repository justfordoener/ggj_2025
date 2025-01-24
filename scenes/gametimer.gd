extends Control

signal timer_finished

@onready var timer : Timer = $Timer
@onready var label : Label= $TimerLabel

@export var start_time_seconds = 15  # 2 minutes in seconds

func _ready():
	timer.wait_time = start_time_seconds 
	timer.autostart = false
	timer.start()
	
func _process(delta):
	if timer.time_left > 0:
		var time_left = int(timer.time_left)
		var minutes = time_left / 60
		var seconds = time_left % 60
		label.text = "%02d:%02d" % [minutes, seconds]


func _on_timer_timeout():
	print("you won nice job bro")
