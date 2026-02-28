extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Vector2($".".global_position.x,$".".global_position.y))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	#$".".global_position.x = RigidBody_location.RigPos.x
	#$".".global_position.y = RigidBody_location.RigPos.y
	pass
