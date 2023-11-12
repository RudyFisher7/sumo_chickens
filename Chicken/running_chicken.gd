extends Node3D


@export var _animation_tree: AnimationTree = null


var _animation_node_playback: AnimationNodeStateMachinePlayback = null

var _direction: Vector3 = Vector3.ZERO
var _speed: float = 2.0


func _ready() -> void:
	_animation_node_playback = _animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	await get_tree().create_timer(randf_range(0.05, 0.3)).timeout
	_animation_node_playback.travel("Run")
	
	_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	look_at(global_position + _direction, Vector3.UP, true)


func _process(delta: float) -> void:
	translate(_direction * _speed * delta)
