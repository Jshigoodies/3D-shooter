extends KinematicBody

func _process(delta):
	var player = get_node("KinematicBody")
	var enemy = get_node("boss")
	enemy.move_toward(player.get_global_transform().origin, 100 * delta)
