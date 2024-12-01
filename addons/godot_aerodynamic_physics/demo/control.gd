extends Control

@onready var PARENT = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var altitude = AeroUnits.get_altitude(self.get_parent())
	altitude = snapped(altitude + 2,1)
	$VBoxContainer/HBoxContainer/Label2.text = str(altitude)
	var speed = PARENT.air_speed
	speed = snapped(speed,1)
	$VBoxContainer/HBoxContainer2/Label2.text = str(speed)
	var throttle = PARENT.throttle_command
	throttle = snapped(throttle,0.01)*100
	$VBoxContainer/HBoxContainer3/Label2.text = str(throttle)
