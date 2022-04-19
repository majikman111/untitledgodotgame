class_name Character
extends KinematicBody2D

# TODO Gravity should be constant singleton and fall speed derived from weight.
export var jump_force = 500
export var gravity = 1000.0
export var fall_cap = 750.0
export var speed = 200
export var invincibility_duration = 1.5
export var max_health = 10

signal health_changed(amount, new_health)
signal died(character)

onready var hurtbox = $Hurtbox
onready var blinker = $Blinker
onready var sprite = $Sprite
onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var animationState = $AnimationTree.get("parameters/playback")

export var velocity = Vector2()
onready var current_health:int = max_health


func idle():
	play_animation("Idle")
	velocity.x = 0


func run():
	play_animation("Run")


func jump():
	play_animation("Jump")
	velocity.y -= jump_force


func fall():
	play_animation("Fall")


func hurt(amount:int):
	current_health -= amount
	emit_signal("health_changed", -amount, current_health)

	play_animation("Hurt")
	velocity.x = 0
	velocity.y = 0


# TODO Character can still attack while dead
func die():
	emit_signal("health_changed", -current_health, 0)
	current_health = 0
	play_animation("Death")
	blinker.stop_blinking()
	emit_signal("died", self)


func move_x(factor, check_flip=true):
	if check_flip:
		if factor > 0 and sprite.is_flipped_h():
			sprite.set_flip_h(false)
		elif factor < 0 and not sprite.is_flipped_h():
			sprite.set_flip_h(true)
	velocity.x = factor * speed


func move_y(y_value):
	velocity.y += y_value


func play_animation(animation_name):
	animationState.travel(animation_name)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y = min(velocity.y + delta * gravity, fall_cap)

	move_and_slide(velocity, Vector2(0, -1))

	if is_on_floor():
		velocity.y = 0

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.


func _on_Hurtbox_area_entered(area):
	if !hurtbox.is_invincible:
		blinker.start_blinking(self, invincibility_duration)
		hurtbox.start_invincibility(invincibility_duration)
