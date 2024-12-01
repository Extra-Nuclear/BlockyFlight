extends Node3D

var template_explosion = preload("res://example/scenes/Explosion/Explosion.tscn")

@onready var aircraft = get_node("AeroBody3D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_aero_body_3d_crashed(impact_velocity: Variant) -> void:
	var new_explosion = template_explosion.instantiate()
	add_child(new_explosion)
	new_explosion.global_transform.origin = $AeroBody3D.global_transform.origin
	new_explosion.explode()
	aircraft.queue_free()
	await get_tree().create_timer(2.0).timeout
	var __= get_tree().reload_current_scene()
