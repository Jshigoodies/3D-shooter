extends Spatial

signal getTime

var badguys

func _ready():
	badguys = 6
	


func _on_KinematicBody_deadKIA():
	badguys = badguys - 1
	if badguys == 0:
		var time = emit_signal("getTime")
	
