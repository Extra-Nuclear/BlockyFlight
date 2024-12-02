extends VehicleWheel3D

@onready var PARENT = self.get_parent()
@onready var THRUSTER = self.get_parent().get_node("AeroThrusterComponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#======BRAKES======
	if Input.is_action_pressed("brakes"):
		self.brake = 25
		print("BRAKING: ", self.rotation_degrees.y)
		#print("BRAKING")
	if not Input.is_action_pressed("brakes"):
		self.brake = 0
		
	#======YAW RIGHT======
	if Input.is_action_pressed("yaw_right"):
		self.steering = 15
		#self.rotation_degrees.y = -15
		print("STEERING RIGHT: ", self.rotation_degrees.y)
		
	
	#======YAW LEFT======
	elif Input.is_action_pressed("yaw_left"):            
		self.steering = -15
		#self.rotation_degrees.y = - 15
		print("STEERING LEFT: ", self.rotation_degrees.y)
		
	else:
		self.steering = 0
		
