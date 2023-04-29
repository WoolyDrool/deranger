extends CharacterBody3D

@export var speed = 10
@export var jump_velocity = 10

var look_sensitivity = ProjectSettings.get_setting("player/look_sensitivity")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0

@onready var camera:Camera3D = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	move(delta)

func move(delta):
	# Horizontal movement vector
	var horizontal_velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").normalized() * speed
	velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z

	# Ground Check
	if is_on_floor():
		velocity_y = 0
		if Input.is_action_just_pressed("move_jump"): velocity_y = jump_velocity
	else:
		velocity_y -= gravity * delta
	velocity.y = velocity_y

	move_and_slide()

	# Mouse
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
