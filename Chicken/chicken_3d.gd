class_name Chicken3D
extends CharacterBody3D


const SPEED: float = 256.0
const JUMP_VELOCITY: float = 4.5
const PUSH_VELOCITY: float = 0.5
const BOUNCE_VELOCITY: float = 0.625
const FRICTION_AMOUNT: float = 0.99


enum {
	PLAYER_1,
	PLAYER_2,
}


@export_enum("PLAYER_1", "PLAYER_2") var _player_id: int = PLAYER_1


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
		PLAYER_2:
			_button_right = KEY_D
			_button_left = KEY_A
			_button_up = KEY_W
			_button_down = KEY_S


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.x = _speed_x
	velocity.z = _speed_z
	
	var collision := move_and_collide(velocity * delta)
	if collision and collision.get_angle() > 0.0:
		if collision.get_collider() is Chicken3D:
			var other_chicken: Chicken3D = collision.get_collider() as Chicken3D
			other_chicken._speed_x -= _speed_x * PUSH_VELOCITY
			other_chicken._speed_z -= _speed_z * PUSH_VELOCITY
			print(velocity)
			print(other_chicken.velocity)
		velocity = velocity.bounce(collision.get_normal())
		_speed_x = -_speed_x * BOUNCE_VELOCITY
		_speed_z = -_speed_z * BOUNCE_VELOCITY
	
	_speed_x *= FRICTION_AMOUNT
	_speed_z *= FRICTION_AMOUNT


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _button_right:
			_speed_x += SPEED
		if event.keycode == _button_left:
			_speed_x -= SPEED
		if event.keycode == _button_up:
			_speed_z -= SPEED
		if event.keycode == _button_down:
			_speed_z += SPEED

