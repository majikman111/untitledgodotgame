class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Queue of history objects to 
var history = []

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export var initial_state := NodePath()

# Path to the owning character so it can be set in the inspector.
#export var character := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
onready var state: State = get_node(initial_state)

# The controlling character
onready var character: Character = get_parent()


func _ready() -> void:
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		child.character = character
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
#func _unhandled_input(event: InputEvent) -> void:
#	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	history.clear()

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)


func interrupt(target_state_name: String, duration: float = 0.0, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	var target_state = get_node(target_state_name)
	# Don't transition to the same state twice
	if state == target_state:
		return
	if not history:
		history.push_back(state)
	state = target_state

	emit_signal("transitioned", state.name)
	state.enter(msg)
	if duration > 0:
		yield(get_tree().create_timer(duration), "timeout")

	pop_history()


func pop_history(msg: Dictionary = {}) -> void:
	if not history:
		return
	
	state.exit()
	state = history.pop_front()
	emit_signal("transitioned", state.name)
	state.enter()
	
