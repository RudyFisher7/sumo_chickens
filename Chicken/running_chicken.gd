extends Node3D


@export var _animation_tree: AnimationTree = null


var _animation_node_playback: AnimationNodeStateMachinePlayback = null

var _direction := Vector3.ZERO
var _speed: float = 2.0
var _previous_position := Vector3.ZERO

func _ready() -> void:
	_animation_node_playback = _animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	await get_tree().create_timer(randf_range(0.05, 0.3)).timeout
	_animation_node_playback.travel("Run")
	
	_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	look_at(global_position + _direction, Vector3.UP, true)
	_previous_position = global_position


func _physics_process(delta: float) -> void:
	translate(_direction * _speed * delta)
	
	if _previous_position.distance_to(global_position) > 2.0 or global_position.abs() > Vector3(4.0, 4.0, 4.0):
		_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
		look_at(global_position + _direction, Vector3.UP, true)
		_previous_position = global_position
