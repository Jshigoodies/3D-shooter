extends Area


func _on_enemy_body_entered(body):
	if body.name == "KinematicBody":
		get_tree().quit()
