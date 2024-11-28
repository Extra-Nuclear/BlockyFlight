extends RigidBody3D


var player_inside = false
var player_node = null

func _on_area_entered(body):
	if body.name == "Player":  # Replace with your player's node name
		player_inside = true
		player_node = body
		print("PLAYER ENTERED CESSNA 172")

func _on_area_exited(body):
	if body.name == "Player":
		player_inside = false
		player_node = null
		print("PLAYER EXITED CESSNA 172")
