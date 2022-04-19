class_name Run
extends State

func enter(_msg := {}) -> void:
	.enter()
	if character.is_on_floor():
		character.run()


func handle_jump_press():
	state_machine.transition_to("Jump")


func handle_x_input(_delta: float, x_value: float) -> void:
	character.move_x(x_value)
	if character.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
