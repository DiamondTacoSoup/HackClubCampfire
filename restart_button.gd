extends Button

func _ready():
	pressed.connect(_on_my_button_pressed)

func _on_my_button_pressed():
	print("Button pressed directly!")
	
	# Find the VictoryArea and tell it to restart
	var victory_area = get_tree().get_first_node_in_group("victory_area")
	if victory_area:
		print("Found victory area, calling restart")
		victory_area.restart_from_button()
	else:
		print("No victory area found, restarting directly")
		get_tree().paused = false
		get_tree().reload_current_scene()
