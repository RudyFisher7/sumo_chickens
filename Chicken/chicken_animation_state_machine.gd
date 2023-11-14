class_name ChickenAnimationStateMachine
extends Node3D


@export var mesh: MeshInstance3D = null

@export var _animation_tree: AnimationTree = null


var _animation_node_playback: AnimationNodeStateMachinePlayback = null
var _parent_chicken: Chicken3D = null

var _timer: SceneTreeTimer = null


func _ready() -> void:
	assert(get_parent_node_3d() is Chicken3D)
	assert(_animation_tree.get("parameters/playback") is AnimationNodeStateMachinePlayback)
	
	_parent_chicken = get_parent_node_3d() as Chicken3D
	
	_animation_node_playback = _animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	
	await get_tree().create_timer(randf_range(0.2, 0.8)).timeout
	_animation_node_playback.travel("Idle")


func _physics_process(delta: float) -> void:
	# Look in the direction the player is trying to go.
	# Note - this may not be the direction the chicken is going due to collision,
	# so use parent's _set_velocity instead of velocity.
	if _parent_chicken._set_velocity.length() > 0.05:
		look_at(_parent_chicken._set_velocity, Vector3.UP, true)
	
	if _parent_chicken.is_on_floor():
		_animation_node_playback.travel("Idle")
	else:
		_animation_node_playback.travel("Jump")
	pass
