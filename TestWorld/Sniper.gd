extends Spatial



func _on_KinematicBody_fire_Gun():
	$AnimationPlayer.play("fire")


func _on_KinematicBody_reload_Gun():
	$AnimationPlayer.play("reload")
