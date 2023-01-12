extends RayCast

signal enemyHit

func _on_KinematicBody_fire_Gun():
	force_raycast_update()

	# Check if the raycast has hit anything
	var hit_object = get_collider()
	if hit_object:
		# The raycast has hit something
		# print("Raycast hit:", hit_object.get_name())
		if hit_object.get_name().find("enemy") != -1:
			hit_object.queue_free()
			emit_signal("enemyHit")
			
	else:
		# The raycast did not hit anything
		# print("Raycast did not hit anything")
		pass


