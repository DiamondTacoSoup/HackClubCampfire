extends Area2D

@export var door_node: Node  # This will appear in the inspector

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	# Check if it's the key
	if area.get_parent() is RigidBody2D:
		# Check if door_node is set and exists
		if door_node:
			door_node.queue_free()
		else:
			print("Door node not assigned in inspector!")
