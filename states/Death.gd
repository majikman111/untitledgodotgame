class_name Death
extends State

func enter(_msg := {}) -> void:
	.enter()
	character.die()
	

func physics_update(_delta: float) -> void:
	if character.is_on_floor():
		character.velocity.x = 0
