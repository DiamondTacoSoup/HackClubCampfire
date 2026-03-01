extends Area2D

# Reference to your victory popup scene
@export var victory_popup_scene: PackedScene  # Drag your victory_popup.tscn here
var victory_popup_instance = null

func _ready():
	# Connect signals
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)  # In case players use Area2D

func _process(delta):
	# Check for R key press when victory popup is active
	if victory_popup_instance != null and Input.is_action_just_pressed("r"):
		print("R pressed - restarting!")
		_on_restart_pressed()

func _on_body_entered(body):
	# Check if it's a player (CharacterBody2D or RigidBody2D)
	if body is CharacterBody2D or body is RigidBody2D:
		trigger_victory()

func _on_area_entered(area):
	# If your players use Area2D for collision
	if area.get_parent() is CharacterBody2D or area.get_parent() is RigidBody2D:
		trigger_victory()

func trigger_victory():
	# Prevent multiple popups
	if victory_popup_instance != null:
		return
	
	# Pause the game
	get_tree().paused = true
	
	# Load and show victory popup
	if victory_popup_scene:
		victory_popup_instance = victory_popup_scene.instantiate()
		add_child(victory_popup_instance)
		
		# Find and connect the restart button
		var restart_button = find_restart_button(victory_popup_instance)
		if restart_button:
			restart_button.pressed.connect(_on_restart_pressed)
		else:
			print("Warning: No restart button found in victory popup")
	else:
		print("Error: Victory popup scene not assigned!")
		# Fallback - just restart after 3 seconds
		await get_tree().create_timer(3.0).timeout
		get_tree().paused = false
		get_tree().reload_current_scene()

func find_restart_button(node) -> Button:
	# Recursively search for a button with "restart" in its name
	if node is Button and "restart" in node.name.to_lower():
		return node
	
	for child in node.get_children():
		var result = find_restart_button(child)
		if result:
			return result
	
	return null

func _on_restart_pressed():
	# Clean up popup
	if victory_popup_instance:
		victory_popup_instance.queue_free()
		victory_popup_instance = null
	
	# Unpause and restart
	get_tree().paused = false
	get_tree().reload_current_scene()
