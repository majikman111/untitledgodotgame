extends Area2D


export var whiten_duration = 0.15
export (ShaderMaterial) var whiten_material
onready var collision_shape = $CollisionShape2D

var is_invincible = false


func start_invincibility(duration):
	is_invincible = true
	collision_shape.set_deferred("disabled", true)
	yield(get_tree().create_timer(duration), "timeout")
	collision_shape.set_deferred("disabled", false)
	is_invincible = false


func _on_Hurtbox_area_entered(area):
	pass
#	whiten_material.set_shader_param("whiten", true)
#	yield(get_tree().create_timer(whiten_duration), "timeout")
#	whiten_material.set_shader_param("whiten", false)
