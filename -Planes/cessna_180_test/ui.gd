extends Control

@onready var PARENT = self.get_parent()


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	var altitude = AeroUnits.get_altitude(self.get_parent())
	altitude = snapped(altitude -2 ,1)
	$Alt/HBoxContainer/Label.text = str(altitude)
	
	var speed = PARENT.air_speed
	speed = snapped(speed,1)
	$Speed/HBoxContainer/Label.text = str(speed)
	
	var throttle = PARENT.throttle_command
	throttle = snapped(throttle,0.01)*100
	$Throttle/ProgressBar.value = int(throttle)
	$Throttle/HBoxContainer/Label.text = str(throttle)
