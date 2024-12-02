extends Control

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	#$AnimationPlayer.play("blur")
	#await get_tree().create_timer(0.2).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pass


func _on_resume_pressed() -> void:
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(0.2).timeout
	self.queue_free()
