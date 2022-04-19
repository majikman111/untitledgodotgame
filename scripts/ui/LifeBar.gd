extends HBoxContainer

export var health_per_container = 2

onready var base_heart_container = preload("res://scenes/ui/HeartContainer.tscn")

signal health_zero()

var max_health = 0
var current_health = 0


func set_max_health(health:int):
	for child in get_children():
		child.queue_free()

	max_health = health

	for i in range(0, health, health_per_container):
		add_child(base_heart_container.instance())


func change_health(value:int):
	if value < 0:
		current_health = max(0, current_health + value)
	else:
		current_health = min(max_health, current_health + value )
	update_bar()


func update_bar():
	for i in range(0, get_child_count()):
		var h_value = i*health_per_container + 1
		if h_value < current_health:
			get_child(i).value = 100
		elif h_value == current_health:
			get_child(i).value = 50
#		elif h_value > current_health:
		else:
			get_child(i).value = 0

	if current_health == 0:
		emit_signal("health_zero")
