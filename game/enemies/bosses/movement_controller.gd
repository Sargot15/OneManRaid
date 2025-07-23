class_name MovementController extends Node

enum MovementState {
	IDLE,
	NORMAL,
	OVERRIDE
}

var current_state: MovementState = MovementState.IDLE
var normal_movement : Callable = Callable()
var override_movement : Callable = Callable()

func _physics_process(delta):
	match current_state:
		MovementState.OVERRIDE:
			if override_movement:
				override_movement.call(delta)
		MovementState.NORMAL:
			if normal_movement:
				normal_movement.call(delta)


func set_idle():
	current_state = MovementState.IDLE


func set_normal_movement(func_callable: Callable):
	normal_movement = func_callable
	current_state = MovementState.NORMAL


func override_with(func_callable: Callable):
	override_movement = func_callable
	current_state = MovementState.OVERRIDE


func clear_override():
	current_state = MovementState.NORMAL
	override_movement = Callable()
