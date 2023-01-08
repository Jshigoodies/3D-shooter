extends KinematicBody
signal fire_Gun
signal reload_Gun

const MOUSE_SENS = 0.1

onready var camera = $root/Camera


# Move
var velocity = Vector3.ZERO
var current_vel = Vector3.ZERO
var dir = Vector3.ZERO

const SPEED = 10
const SPRINT_SPEED = 20
const ACCEL = 15.0

# Jump

const GRAVITY = -40.0
const JUMP_SPEED = 15
var jump_counter = 0
const AIR_ACCEL = 9.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	fire_gun()
	reload_gun()
	window_activity()

# Called every frame
func _physics_process(delta):
	dir = Vector3.ZERO
	
	if Input.is_action_pressed("w"):
		dir -= camera.global_transform.basis.z
	if Input.is_action_pressed("s"):
		dir += camera.global_transform.basis.z
	if Input.is_action_pressed("d"):
		dir += camera.global_transform.basis.x
	if Input.is_action_pressed("a"):
		dir -= camera.global_transform.basis.x
	
	
	dir = dir.normalized()
	
	
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		jump_counter = 0
		
	# Jump
	if Input.is_action_just_pressed("spacebar") and jump_counter < 2:
		jump_counter += 1
		velocity.y = JUMP_SPEED
		
	# Set speed and target vel
	var speed = SPRINT_SPEED if Input.is_action_pressed("shift") else SPEED
	var target_vel = dir * speed
	
	# Smooth out the player's movement
	var accel = ACCEL if is_on_floor() else AIR_ACCEL
	current_vel = current_vel.linear_interpolate(target_vel, accel * delta)
	
	velocity.x = current_vel.x
	velocity.z = current_vel.z
	
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45))

func fire_gun():
	if Input.is_action_just_pressed("lmb"):
		emit_signal("fire_Gun")

func reload_gun():
	if Input.is_action_just_pressed("rmb"):
		emit_signal("reload_Gun")

func _input(event):
	if event is InputEventMouseMotion:
		# Rotates the view vertically
		$root.rotate_x(deg2rad(event.relative.y * MOUSE_SENS * -1))
		$root.rotation_degrees.x = clamp($root.rotation_degrees.x, -75, 75)
		
		# Rotates the view horizontally
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENS * -1))

# To show/hide the cursor
func window_activity():
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_RayCast_hit():
	emit_signal("hit_bad_guy")
