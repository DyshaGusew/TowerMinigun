extends Panel

func _on_returned_in_game_pressed():
	hide()
	get_tree().paused = !get_tree().paused
	get_parent().get_node("Upgrade").disabled = false
	

func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
