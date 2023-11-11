class_name Chicken3D
extends CharacterBody3D


const SPEED: float = 128.0
const JUMP_VELOCITY: float = 4.5


enum {
	PLAYER_1,
	PLAYER_2,
}


@export_enum("PLAYER_1", "PLAYER_2") var _player_id: int = PLAYER_1


var _speed: float = 0.0
var _button: int = KEY_LEFT

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	match _player_id:
		PLAYER_1:
			_button = KEY_LEFT
		PLAYER_2:
			_button = KEY_D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.x = _speed
	
	var collision := move_and_collide(velocity * delta)
	if collision.get_angle() > 0.0:
		velocity = collision.get_collider_velocity()
		velocity = velocity.bounce(collision.get_normal())
		_speed = -_speed / 2.0
		print(collision.get_angle())


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _button:
			_speed += _get_speed(_player_id)


func _get_speed(in_player_id: int) -> float:
	var result: float = 0.0
	
	match in_player_id:
		PLAYER_1:
			result = -SPEED
		PLAYER_2:
			result = SPEED
	
	return result
