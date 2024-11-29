extends Node3D

var max_angle = 30.0  # Maximum rotation in degrees
var rotation_speed = 5.0  # Speed of movement

func _process(delta):
	if Input.is_action_pressed("yaw_left"):
		rotation_degrees = clamp(rotation_degrees + rotation_speed, -max_angle, max_angle)
	elif Input.is_action_pressed("yaw_right"):
		rotation_degrees = clamp(rotation_degrees - rotation_speed, -max_angle, max_angle)
	else:
		rotation_degrees = lerp(rotation_degrees, 0, 0.1)  # Reset to neutral position
	
	rotation_degrees = clamp(rotation_degrees, -max_angle, max_angle)
	rotation = Basis(Vector3(0, 1, 0), deg_to_rad(rotation_degrees))  # Rotate on the Y-axis
