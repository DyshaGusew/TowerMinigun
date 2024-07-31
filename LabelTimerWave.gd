extends Label

@export var count = 5
signal timer_end()


func _ready():
	$Timer.start()
	text = "До следующей волны: " + str(count)

func _on_timer_timeout():
	count -= 1
	$Timer.start()
	text = "До следующей волны: " + str(count)
	if count <= 0:
		$Timer.stop()
		timer_end.emit()
