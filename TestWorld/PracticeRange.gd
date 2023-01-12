extends Spatial


var healthBoss = 200

signal time


func _on_KinematicBody_deadKIA():
	healthBoss = healthBoss - 1
	# print(healthBoss)
	if healthBoss == 0:
		emit_signal("time")
