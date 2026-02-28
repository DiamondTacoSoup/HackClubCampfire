extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var InRig = false
var pinJoint: PinJoint2D
var actionableTest = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	RigidBody_location.Player1pos = global_position
	
	if Input.is_action_just_pressed("r") or $".".global_position.y > 50 :
		get_tree().reload_current_scene()


	var x_direction := Input.get_axis("key_a", "key_d")
	var y_direction := Input.get_axis("key_w", "key_s")

	# 2. Combine them into a single direction vector
	var direction := Vector2(x_direction, y_direction)

	# 3. Normalize the direction! 
	# (This stops you from moving 40% faster when walking diagonally)
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if Input.is_action_just_pressed("shift") and actionableTest == true:
		pinJoint = PinJoint2D.new()
		pinJoint.softness = 0
		add_child(pinJoint)
		pinJoint.node_a = self.get_path()
		pinJoint.node_b = get_node("../TestBlock").get_path()
		
	if Input.is_action_just_released("shift"):
		if pinJoint != null:
			pinJoint.queue_free() # Deletes the joint node
			pinJoint = null       # Clears the reference
		
	move_and_slide()
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	actionableTest = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	actionableTest = false
	pass # Replace with function body.
	
