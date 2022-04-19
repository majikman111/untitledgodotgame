class_name Fall
extends State


func handle_x_input(_delta: float, x_value: float) -> void:
	character.move_x(x_value)
	

func physics_update(_delta: float) -> void:
	# TODO Change to is_on_floor
	if character.is_on_floor():
		# TODO landing state for an animation? IDK
		state_machine.transition_to("Idle")
