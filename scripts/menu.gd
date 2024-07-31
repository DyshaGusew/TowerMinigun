extends Node2D

var game_scene = load("res://scenes/main.tscn").instantiate()

func _on_exit_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_continue_pressed():
	pass # Replace with function body.
