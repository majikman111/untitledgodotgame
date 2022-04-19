# Virtual base class for all states.
class_name State
extends Node


# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null

# We also keep a reference to the owning character
var character: Character = null

# TODO Emit these signals...
signal enter_state()
signal exit_state()


# Virtual function. Receives events from the `_unhandled_input()` callback.
#func handle_input(_event: InputEvent) -> void:
#	pass

## Functions for handling known input events
func handle_left_press() -> void:
	pass

func handle_left_hold(_delta: float) -> void:
	pass

func handle_left_release() -> void:
	pass

func handle_right_press() -> void:
	pass

func handle_right_hold(_delta: float) -> void:
	pass

func handle_right_release() -> void:
	pass

func handle_x_input(_delta: float, _x_value: float) -> void:
	pass

func handle_jump_press() -> void:
	pass

func handle_jump_hold(_delta: float) -> void:
	pass

func handle_jump_release() -> void:
	pass

func handle_special_press() -> void:
	pass

func handle_special_hold(_delta: float) -> void:
	pass

func handle_special_release() -> void:
	pass

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
# TODO Have these by default just play the named animation for the state...maybe?
func enter(_msg := {}) -> void:
	emit_signal("enter_state")


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	emit_signal("exit_state")
