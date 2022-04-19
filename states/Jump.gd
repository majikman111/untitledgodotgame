class_name Jump
extends State


func enter(_msg := {}) -> void:
	.enter()
	if character.is_on_floor():
		character.jump()
	else:
		state_machine.transition_to("Idle")

func handle_x_input(_delta: float, x_value: float) -> void:
	character.move_x(x_value)


# Stop upward momentum mostly once the button is released
func handle_jump_release() -> void:
	character.velocity.y = max(-100, character.velocity.y)


func physics_update(_delta: float) -> void:
	if character.velocity.y >= 0 or character.is_on_ceiling():
		state_machine.transition_to("Fall")

