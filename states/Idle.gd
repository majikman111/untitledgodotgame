# Idle.gd
class_name Idle
extends State

var first_frame = false
# TODO Character enters idle for one fram when moving quickly from left to right.

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	.enter()
	first_frame = true

func handle_jump_press():
	state_machine.transition_to("Jump")

#func physics_update(_delta: float) -> void:
func handle_x_input(_delta: float, x_value: float) -> void:
	if x_value != 0:
		state_machine.transition_to("Run")
	elif first_frame:
		first_frame = false
	else:
		character.idle()


func physics_update(_delta: float) -> void:
	# TODO Change to is_on_floor
	if not character.is_on_floor():
		# TODO landing state for an animation? IDK
		state_machine.transition_to("Fall")

#	if Input.is_action_just_pressed("move_up"):
#		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
#		# to tell the next state that we want to jump.
#		state_machine.transition_to("Air", {do_jump = true})
#	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
#		state_machine.transition_to("Run")
