extends Node3D  # Or Spatial, depending on your node type

var spin_speed = 3000.0  # Degrees per second (Increase this value for faster spinning)

func _process(delta):
	# Rotate the propeller around the local Z-axis (assuming Z is forward)
	rotate_x(deg_to_rad(spin_speed * delta))
