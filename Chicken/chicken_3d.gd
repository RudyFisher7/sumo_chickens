class_name Chicken3D
extends CharacterBody3D


const SPEED: float = 10.0
const JUMP_VELOCITY: float = 1.5
const PUSH_VELOCITY: float = 0.5
const BOUNCE_VELOCITY: float = 0.2
const FRICTION_AMOUNT: float = 0.91


enum {
	PLAYER_1,
	PLAYER_2,
}


@export_enum("PLAYER_1", "PLAYER_2") var player_id: int = PLAYER_1
@export var mesh: MeshInstance3D = null
@export var shape: CylinderShape3D = null


var _joypad_id: int = 0

var sumo_size: float = 0.0

var _set_velocity: Vector3 = Vector3.ZERO
var speed_x: float = 0.0
var speed_z: float = 0.0
var _button_right: int = 0
var _button_left: int = 0
var _button_up: int = 0
var _button_down: int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	shape = $CollisionShape3D.shape as CylinderShape3D
	mesh = $ChickenAnimationStateMachine.mesh
	match player_id:
		PLAYER_1:
			_button_right = KEY_RIGHT
			_button_left = KEY_LEFT
			_button_up = KEY_UP
			_button_down = KEY_DOWN
			sumo_size = 0.9
			_joypad_id = 0
		PLAYER_2:
			_button_right = KEY_D
			_button_left = KEY_A
			_button_up = KEY_W
			_button_down = KEY_S
			sumo_size = 0.9
			_joypad_id = 1


func _physics_process(delta: float) -> void:		
	velocity.x = speed_x
	velocity.z = speed_z
	
	# Handle Jump and gravity
	if is_on_floor() and _directionalInput():
		velocity.y = JUMP_VELOCITY + sumo_size
	elif not is_on_floor():
		velocity.y -= gravity * delta + (1 / sumo_size)
	
	move_and_slide()
	
	var collision: KinematicCollision3D = get_last_slide_collision()
	
	if collision and collision.get_collider() is Chicken3D:
		var other_chicken: Chicken3D = collision.get_collider() as Chicken3D
		if other_chicken.sumo_size > 0.0 and sumo_size > 0.0:
			other_chicken.speed_x = _set_velocity.x * PUSH_VELOCITY * (sumo_size / other_chicken.sumo_size)
			other_chicken.speed_z = _set_velocity.z * PUSH_VELOCITY * (sumo_size / other_chicken.sumo_size)
			other_chicken.velocity.y += (JUMP_VELOCITY + sumo_size) * (sumo_size / other_chicken.sumo_size)
			speed_x = -_set_velocity.x * BOUNCE_VELOCITY * (other_chicken.sumo_size / sumo_size)
			speed_z = -_set_velocity.z * BOUNCE_VELOCITY * (other_chicken.sumo_size / sumo_size)
			$AudioBounce.play()
			
	speed_x *= FRICTION_AMOUNT
	speed_z *= FRICTION_AMOUNT


func _directionalInput() -> bool:
	var was_pressed := false
	
	_set_velocity = Vector3.ZERO
	
	var input_axes := Vector2.ZERO
	
	if player_id == PLAYER_1:
		input_axes = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	if player_id == PLAYER_2:
		input_axes = Input.get_vector("ui_right_2p", "ui_left_2p", "ui_down_2p", "ui_up_2p")
	
	_set_velocity.x = input_axes.x * -SPEED
	_set_velocity.z = input_axes.y * -SPEED
	
	was_pressed = input_axes.length() > 0.0
	
	if was_pressed:
		speed_x = _set_velocity.x
		speed_z = _set_velocity.z
		$AudioWalk.play()
	
	return was_pressed

