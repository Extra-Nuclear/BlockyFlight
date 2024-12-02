extends VehicleWheel3D

@onready var PARENT = self.get_parent()
@onready var THRUSTER = self.get_parent().get_node("AeroThrusterComponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("brakes"):
		self.brake = 25
		#print("BRAKING")
	if not Input.is_action_pressed("brakes"):
		self.brake = 0
	if Input.is_action_pressed("yaw_right"):
		self.steering = -15
		#THRUSTER.rotation_degrees.y = 345
		print("STEERING RIGHT")
	if not Input.is_action_pressed("yaw_right"):
		self.steering = 0
		#THRUSTER.rotation_degrees.y = 0
	if Input.is_action_pressed("yaw_left"):
		#THRUSTER.rotation_degrees.y = 15
		print("STEERING LEFT")
		self.steering = 15
	if not Input.is_action_pressed("yaw_left"):
		self.steering = 0
		#THRUSTER.rotation_degrees.y = 0
