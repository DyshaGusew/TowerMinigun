extends Node2D

signal game_over(count_wave, count_monsters, count_xp)

@export var mob_scene: PackedScene
@export var healh_base = 10
var xp_base = 20
var num_wave_monsters = 1
var sleep_between_wave = 5

var flag_start = true

var count_wave = num_wave_monsters - 1
var count_monsters = 0
var count_xp = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var _game_scene = preload("res://scenes/menu.tscn").instantiate()
	update_healh_lable()
	update_XP_lable()
	update_level_lable()
	
# Action of monsters
func _on_monster_base_died(monster):
	monster.queue_free()
	count_monsters += 1
	await get_tree().create_timer(0.005).timeout
	
	if !get_tree().get_nodes_in_group("Monsters") and healh_base > 0:
		$LabelTimerWave.start_timer(sleep_between_wave)
		
func _on_monster_base_damage_defence(damage):
	healh_base -= damage
	if healh_base <= 0:
		healh_base = 0
		game_over.emit(count_wave, count_monsters, count_xp)
	
	update_healh_lable()

func _on_monster_base_died_bullet_monster(XP):
	xp_base += XP
	count_xp += XP
	update_XP_lable()
	
func _on_label_timer_wave_timer_wave_end(second_stay):
	xp_base += second_stay * 5
	count_xp += second_stay * 5
	update_XP_lable()
	
	num_wave_monsters += 1
	update_level_lable()
	created_wave_monsters()
	
func created_wave_monsters():
	count_wave += 1
	for i in num_wave_monsters:
		var mob = mob_scene.instantiate()
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.progress_ratio = randf()
		mob.position = mob_spawn_location.position
		
		add_child(mob)
		
		mob.died.connect(_on_monster_base_died)
		mob.died_bullet_monster.connect(_on_monster_base_died_bullet_monster)
		mob.damage_defence.connect(_on_monster_base_damage_defence)

# Set params
func set_XP_lable(value):
	if xp_base < 0:
		xp_base = 0
	else:
		xp_base = value

	update_XP_lable()

# Draw info
func update_level_lable():
	$LavelLable.text = "Уровень:  " + str(num_wave_monsters)

func update_healh_lable():
	$HpLable.text = "Здоровье: " + str(healh_base)
	
func update_XP_lable():
	$CounterXP.text = "Опыт: " + str(xp_base)


###Button pressed
func _on_fone_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and flag_start:
		flag_start = false
		$TabLabel.hide()
		update_healh_lable()
		update_XP_lable()
		update_level_lable()
		$Turel.start_shooting()
		created_wave_monsters()

func _on_pause_pressed():
	$Upgrade.disabled = !$Upgrade.disabled
	get_tree().paused = !get_tree().paused
	$PauseMenu.visible = !$PauseMenu.visible

func _on_upgrade_pressed():
	$Turel.flag_rotate = !$Turel.flag_rotate
	$Turel.flag_gun = !$Turel.flag_gun
	$PanelUpgrades.visible = !$PanelUpgrades.visible

func _on_new_game_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
