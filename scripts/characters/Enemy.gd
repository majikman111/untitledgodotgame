extends Character
#extends KinematicBody2D

#
#func _physics_process(delta):
#	pass
#	if not is_on_floor():
#		velocity.y = min(velocity.y + delta * gravity, fall_cap)
#	velocity = Vector2.ZERO
#	move_and_slide(velocity, Vector2(0, -1))
#	print(velocity)
#
#	if is_on_floor():
#		velocity.y = 0

func die():
	.die()
	$HitBox/CollisionShape2D.call_deferred("set_disabled", true)
	$HitBox.call_deferred("set_monitorable", false)
	# TODO Yield then queue_free
#	queue_free()
