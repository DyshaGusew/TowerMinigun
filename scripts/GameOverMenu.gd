extends Panel


func _on_main_game_over(count_wave, count_monsters, count_xp):
	await get_tree().create_timer(0.3).timeout
	show()
	get_tree().paused = true
	get_parent().get_node("PanelUpgrades").hide()
	get_parent().get_node("LabelTimerWave").hide()
	$LabelWave.text = "Волн пережито: " + str(count_wave)
	$LabelMonsters.text = "Монстров убито: " + str(count_monsters)
	$LabelXp.text = "Опыта заработано: " + str(count_xp)
