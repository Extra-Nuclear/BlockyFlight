extends RigidBody3D

@onready var is_in_control = false

@onready var PLAYER = get_parent().get_node("Player")
@onready var PLAYER_CAM = get_parent().get_node("Player/Pivot/Camera3D")

var player_inside = false
var player_node = null
var plane_camera = null
var plane_camera_outside = null

func _on_area_entered(body):
	if body.name == "Player":  # Replace with your player's node name
		player_inside = true
		player_node = body
		print("PLAYER - Entered (Cessna 172)")
		body.show_interact("E","Enter")

func _on_area_exited(body):
	if body.name == "Player":
		player_inside = false
		player_node = null
		print("PLAYER - Exited (Cessna 172)")
		body.hide_interact()

# Movement parameters
var thrust = 5.0
var pitch_speed = 1.0
var yaw_speed = 0.5
var roll_speed = 0.5     # Roll control sensitivity (A/D keys)

# Moving part angles
var rudder_angle = 0.0
var aileron_angle = 0.0
var max_rudder_angle = 30.0    # Degrees for yaw movement
var max_aileron_angle = 15.0   # De	grees for roll movement

# Propeller speed
var propeller_speed = 1000.0   # Degrees per second

func _ready() -> void:
	plane_camera = $Camera
	plane_camera_outside = $"Outside Camera"
	print("Plane camera:", plane_camera)


func switch_to_plane_camera():
	if plane_camera:
		plane_camera.current = true
		print("Camera switched to PlaneCamera")
	else:
		print("Plane camera is not found!")

		


func _process(delta):
	if player_inside:
		pass
		#print("PLAYER INSIDE")
	if Input.is_action_just_pressed("interact") and player_inside:
		# Hide the player and transfer control to the plane
		player_node.visible = false
		player_node.queue_free()
		player_node.set_physics_process(false)  # Stop player movement
		self.set("is_in_control", true)  # Notify plane script
		is_in_control = true
		self.set("is_in_control", true)  # Notify plane script
		switch_to_plane_camera()
		print("INTERACT")
	if Input.is_action_just_pressed("plane_switch_camera"):
		if plane_camera.current == true:
			plane_camera_outside.current = true
		elif plane_camera_outside.current == true:
			plane_camera.current = true
	

func _physics_process(delta):
	# Thrust (W key)
	print("Mass:", mass, "Inertia:", inertia)
	print("Applied pitch torque (global):", global_transform.basis.x * pitch_speed)
	
	if Input.is_action_pressed("plane_thrust_up") and is_in_control:
		apply_central_force(transform.basis.x * thrust)

	# Pitch (Arrow Up/Down)
	if Input.is_action_pressed("plane_pitch_up") and is_in_control:
		apply_torque(Vector3(1, 0, 0) * pitch_speed)
		#print("Applying pitch up torque")
	elif Input.is_action_pressed("plane_pitch_down") and is_in_control:
		apply_torque(Vector3(-1, 0, 0) * pitch_speed)
		#print("Applying pitch down torque")
	# Yaw (Arrow Left/Right)
	if Input.is_action_pressed("plane_yaw_left") and is_in_control:
		apply_torque(Vector3(0, 1, 0) * yaw_speed)
		rudder_angle = clamp(rudder_angle + yaw_speed * delta * 30, -max_rudder_angle, max_rudder_angle)
	elif Input.is_action_pressed("plane_yaw_right") and is_in_control:
		apply_torque(Vector3(0, -1, 0) * yaw_speed)
		rudder_angle = clamp(rudder_angle - yaw_speed * delta * 30, -max_rudder_angle, max_rudder_angle)
	else:
		rudder_angle = lerp(rudder_angle, 0.1, 0.1)  # Reset rudder to center
	$Moving/Rudder.rotation_degrees.y = rudder_angle
	if Input.is_action_pressed("test"):
		apply_torque(Vector3(1, 0, 0) * pitch_speed)  # Apply constant pitch torque
	# Roll (A/D keys)
	if Input.is_action_pressed("plane_roll_left") and is_in_control:
		apply_torque(Vector3(0, 0, 1) * roll_speed)
		aileron_angle = clamp(aileron_angle + roll_speed * delta * 30, -max_aileron_angle, max_aileron_angle)
	elif Input.is_action_pressed("plane_roll_right") and is_in_control:
		apply_torque(Vector3(0, 0, -1) * roll_speed)
		aileron_angle = clamp(aileron_angle - roll_speed * delta * 30, -max_aileron_angle, max_aileron_angle)
	else:
		aileron_angle = lerp(aileron_angle, 0.1, 0.1)  # Reset ailerons to neutral
	$Moving/Ailerons/Left.rotation_degrees.z = aileron_angle
	$Moving/Ailerons/Right.rotation_degrees.z = -aileron_angle  # Inverted for the opposite aileron

	# Spin Propeller
	#$Moving/Blades.rotate_x(deg_to_rad(propeller_speed* delta))
	
	print("Plane rotation:", transform.basis.get_euler())
