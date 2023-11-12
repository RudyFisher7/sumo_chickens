class_name ChickenAnimationStateMachine
extends Node3D


@export var _animation_player: AnimationPlayer = null


var _parent_chicken: CharacterBody3D = null


func _ready() -> void:
	assert(get_parent_node_3d() is CharacterBody3D)
	if get_parent_node_3d() is CharacterBody3D:
		_parent_chicken = get_parent_node_3d() as CharacterBody3D


func _physics_process(delta: float) -> void:
	look_at(-_parent_chicken.velocity)
	if _parent_chicken.is_on_floor():
		_animation_player.play("Idle")
	else:
		_animation_player.play("Jump")
