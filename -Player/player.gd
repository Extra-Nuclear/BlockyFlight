extends CharacterBody3D

@onready var PARENT = self.get_parent()

@onready var camera = $Pivot  # Make sure to reference your camera node
@onready var cameracamera = $Pivot/Camera3D

@onready var IntL = $UI/Label

var target_vertical_rotation: float = 0.0
var target_horizontal_rotation: float = 0.0
var camera_vertical_rotation: float = 0.0
var camera_horizontal_rotation: float = 0.0
var mouse_sensitivity: float = 0.2
var max_vertical_angle: float = 80.0

var speed = 5.0
var gravity = -9.8
var walking = false
var paused = false
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera_vertical_rotation = camera.rotation_degrees.x
	IntL.visible = false


func _process(delta: float) -> void:
	Movement(delta)

func Movement(delta):
	var direction = Vector3.ZERO
	walking = false
	if Input.is_action_pressed("walk_forward") and paused == false:
		walking = true
		direction.z -= 0.3
	if Input.is_action_pressed("walk_backward") and paused == false:
		walking = true
		direction.z += 0.3
	if Input.is_action_pressed("walk_left") and paused == false:
		walking = true
		direction.x -= 0.3
	if Input.is_action_pressed("walk_right") and paused == false:
		walking = true
		direction.x += 0.3
	
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	direction = direction.normalized()
	var cam_basis = get_transform().basis
	var move_direction = (cam_basis.x * direction.x) + (cam_basis.z * direction.z)
	move_direction = move_direction.normalized() * speed

	# Apply gravity to the y-axis
	velocity.y += gravity * delta

	# Update the velocity (x, z for movement, y for gravity)
	velocity.x = move_direction.x
	velocity.z = move_direction.z

	# Move the player with collisions
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion and paused == false:
		# Horizontal rotation (left-right) on player body
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		# Vertical rotation (up-down) on camera
		camera_vertical_rotation -= event.relative.y * mouse_sensitivity
		camera_vertical_rotation = clamp(camera_vertical_rotation, -max_vertical_angle, max_vertical_angle)
		
		# Apply the clamped rotation to the camera's X-axis
		camera.rotation_degrees.x = camera_vertical_rotation

func show_interact(interaction_letter : String, interaction_label : String):
	IntL.text = str("[", str(interaction_letter), "] To ", str(interaction_label))
	IntL.visible = true

func hide_interact():
	IntL.visible = false
