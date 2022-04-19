extends Node

onready var character: Character = get_child(0)
onready var state_machine: StateMachine = character.get_node("StateMachine")


func _on_Enemy_died(character):
	character.queue_free()
