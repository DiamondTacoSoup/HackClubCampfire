extends Bone2D

# Input global positions

# Measure your tentacle art length in pixels (e.g., if it's 64px long)
@export var original_width: float = 64.0

func _process(_delta):
	# 1. Position the bone at the first point
	global_position = RigidBody_location.Player2pos
	
	# 2. Calculate the vector from point A to point B
	var direction_vec = RigidBody_location.Player2pos - RigidBody_location.Player1pos
	
	# 3. Set the rotation (Godot assumes 0 rad is pointing Right / +X)
	global_rotation = -direction_vec.angle()
	global_rotation = direction_vec.angle() + deg_to_rad(180)
	
	# 4. Scale the bone to match the distance
	var distance = direction_vec.length()
	
	# We scale X because 'angle()' aligns the X-axis with the vector
	if original_width > 0:
		scale.x = distance / original_width
