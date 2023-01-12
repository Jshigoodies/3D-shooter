extends Control

var time = 0

func _ready():
	$Label.text = str(time)

func _on_Timer_timeout():
	time = time + 1
	$Label.text = str(time)

func _on_World_getTime():
	$Timer.stop()
	$Label.text = str(time)


func _on_PracticeRange_time():
	$Timer.stop()
	$Label.text = str(time)
	$Win.visible = true
