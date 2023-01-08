extends Area



func _on_KinematicBody_hit_bad_guy():
	queue_free()
