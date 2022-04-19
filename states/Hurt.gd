class_name Hurt
extends State

export var x_factor = .75
export var y_force = 200
export var duration: float = 0.35

var input_pos: Vector2 = Vector2.ZERO
var sum_delta = 0.0

func _on_Hurtbox_area_entered(area: Area2D):
	# TODO This is not correct
	input_pos = area.get_parent().position
	state_machine.interrupt(self.name, duration)


func enter(_msg := {}) -> void:
	.enter()
	# TODO Calculate hurt value?
	character.hurt(1)

	var x_direction = sign(character.position.x - input_pos.x)
	var y_direction = sign(character.position.y - input_pos.y)

	character.move_x(x_direction * x_factor, false)
	character.move_y(y_direction * y_force)

	if character.current_health <= 0:
		state_machine.transition_to("Death")
