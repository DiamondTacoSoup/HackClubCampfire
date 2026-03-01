extends Area2D

@export var door: StaticBody2D  # Drag your door here in inspector

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	# Check if the entering area belongs to the key
	if area.get_parent() is RigidBody2D and area.get_parent().name == "TestBlock":
		if door != null:
			door.queue_free()
			print("Door removed!")
		else:
			print("Door is null - assign it in the inspector!")
