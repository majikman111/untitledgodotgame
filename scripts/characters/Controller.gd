extends Node

onready var character: Character = get_child(0)
onready var state_machine: StateMachine = character.get_node("StateMachine")
onready var gui = $GUI
onready var lifebar =  $GUI/LifeBar


func get_x_input():
	return Input.get_action_strength("right") - Input.get_action_strength("left")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		state_machine.interrupt("Attack", 0.0001)
		return

	if event.is_action_pressed("left"):
		state_machine.state.handle_left_press()
	elif event.is_action_released("left"):
		state_machine.state.handle_left_release()

	if event.is_action_pressed("right"):
		state_machine.state.handle_right_press()
	elif event.is_action_released("right"):
		state_machine.state.handle_right_release()
	
	if event.is_action_pressed("jump"):
		state_machine.state.handle_jump_press()
	elif event.is_action_released("jump"):
		state_machine.state.handle_jump_release()
	
	if event.is_action_pressed("special"):
		state_machine.state.handle_special_press()
	elif event.is_action_released("special"):
		state_machine.state.handle_special_release()


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("connect_character")


func _on_player_health_changed(amount, new_health):
	gui.get_node("LifeBar").change_health(amount)


func connect_character():
	state_machine = character.get_node("StateMachine")
	
	lifebar.set_max_health(character.max_health)
	lifebar.current_health = character.current_health

	character.connect("health_changed", self, "_on_player_health_changed")


func swap_character(new_character):
	character.disconnect("health_changed", self, "_on_player_health_changed")
	
	character = new_character
	
	connect_character()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left"):
		state_machine.state.handle_left_hold(delta)
	if Input.is_action_pressed("right"):
		state_machine.state.handle_right_hold(delta)
	if Input.is_action_pressed("jump"):
		state_machine.state.handle_jump_hold(delta)
	if Input.is_action_pressed("special"):
		state_machine.state.handle_special_hold(delta)
	
	state_machine.state.handle_x_input(delta, get_x_input())
