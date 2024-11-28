extends Node2D

@onready var Credits = $Others/Credits
@onready var Settings = $Others/Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Credits.visible = false
	Settings.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	Settings.visible = true
	Credits.visible = false

func _on_credits_pressed() -> void:
	Credits.visible = true
	Settings.visible = false


func _on_start_pressed() -> void:
	pass # Replace with function body.
