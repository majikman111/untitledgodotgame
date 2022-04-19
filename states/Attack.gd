class_name Attack
extends State

export var AttackName = "Attack1"

func enter(_msg := {}) -> void:
	.enter()
	if character.animationPlayer.has_animation(AttackName):
		character.animationState.travel(AttackName)


#func handle_jump_press():
#	state_machine.transition_to("Jump")


func handle_x_input(_delta: float, x_value: float) -> void:
	character.move_x(x_value, false)
