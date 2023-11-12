class_name Chicken3D
extends CharacterBody3D


const SPEED: float = 10.0
const JUMP_VELOCITY: float = 1.5
const PUSH_VELOCITY: float = 0.5
const BOUNCE_VELOCITY: float = 0.2
const FRICTION_AMOUNT: float = 0.95


enum {
	PLAYER_1,
	PLAYER_2,
}


@export_enum("PLAYER_1", "PLAYER_2") var _player_id: int = PLAYER_1


var _sumo_size: float = 0.0

var _set_velocity: Vector3 = Vector3.ZERO
var _speed_x: float = 0.0
var _speed_z: float = 0.0
var _button_right: int = 0
var _button_left: int = 0
var _button_up: int = 0
var _button_down: int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	match _player_id:
		PLAYER_1:
			_button_right = KEY_RIGHT
			_button_left = KEY_LEFT
			_button_up = KEY_UP
			_button_down = KEY_DOWN
			_sumo_size = 4.9
		PLAYER_2:
			_button_right = KEY_D
			_button_left = KEY_A
			_button_up = KEY_W
			_button_down = KEY_S
			_sumo_size = 0.9


func _physics_process(delta: float) -> void:
	velocity.x = _speed_x
	velocity.z = _speed_z
	
	# Handle Jump and gravity
	if is_on_floor() and _directionalInput():
		velocity.y = JUMP_VELOCITY + _sumo_size
	elif not is_on_floor():
		velocity.y -= gravity * delta + (1 / _sumo_size)
	
	move_and_slide()
	
	var collision: KinematicCollision3D = get_last_slide_collision()
	
	if collision and collision.get_collider() is Chicken3D:
		var other_chicken: Chicken3D = collision.get_collider() as Chicken3D
		if other_chicken._sumo_size > 0.0 and _sumo_size > 0.0:
			other_chicken._speed_x = _set_velocity.x * PUSH_VELOCITY * (_sumo_size / other_chicken._sumo_size)
			other_chicken._speed_z = _set_velocity.z * PUSH_VELOCITY * (_sumo_size / other_chicken._sumo_size)
			other_chicken.velocity.y += (JUMP_VELOCITY + _sumo_size) * (_sumo_size / other_chicken._sumo_size)
			_speed_x = -_set_velocity.x * BOUNCE_VELOCITY * (other_chicken._sumo_size / _sumo_size)
			_speed_z = -_set_velocity.z * BOUNCE_VELOCITY * (other_chicken._sumo_size / _sumo_size)
	
	_speed_x *= FRICTION_AMOUNT
	_speed_z *= FRICTION_AMOUNT




func _directionalInput() -> bool:
	var wasPressed := false
	
	_set_velocity = Vector3.ZERO
	
	if Input.is_key_pressed(_button_right):
		_set_velocity.x = SPEED
		wasPressed = true
	if Input.is_key_pressed(_button_left):
		_set_velocity.x = -SPEED
		wasPressed = true
	if Input.is_key_pressed(_button_up):
		_set_velocity.z = -SPEED
		wasPressed = true
	if Input.is_key_pressed(_button_down):
		_set_velocity.z = SPEED
		wasPressed = true
	
	if wasPressed:
		_speed_x = _set_velocity.x
		_speed_z = _set_velocity.z
	
	return wasPressed

