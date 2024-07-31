extends Panel

var rotation_level = 1
var speed_bullet_level = 1
var damage_level = 1
var reload_level = 1

var rotation_cost = 7
var speed_bullet_cost = 5
var damage_cost = 10
var reload_cost = 10

var max_damade_level = 6
var max_reload_level = 100
var max_speed_bullet_level = 8
var max_rotation_level = 10



func _on_upgrade_pressed():
	set_text_levels()
	set_text_cost()

func set_text_levels():
	$Rotation/LabelLevel.text = "Уровень " + str(rotation_level)
	$SpeedBullet/LabelLevel.text = "Уровень " + str(speed_bullet_level)
	$Damage/LabelLevel.text = "Уровень " + str(damage_level)
	$Reload/LabelLevel.text = "Уровень " + str(reload_level)

func set_text_cost():
	$Rotation/LableCost.text = "Цена " + str(rotation_cost)
	$SpeedBullet/LableCost.text = "Цена " + str(speed_bullet_cost)
	$Damage/LableCost.text = "Цена " + str(damage_cost)
	$Reload/LableCost.text = "Цена " + str(reload_cost)


func check_wallet(cost):
	return get_parent().xp_base >= cost

func _on_button_upgrade_rotation_pressed():
	if rotation_level < max_rotation_level:
		if check_wallet(rotation_cost):
			get_parent().set_XP_lable(get_parent().xp_base - rotation_cost)
			rotation_level += 1
			get_parent().get_node("Turel").update_rotation(rotation_level)
			rotation_cost *= 2
			
			set_text_levels()
			set_text_cost()
		if rotation_level == max_rotation_level:
					$Rotation/LabelMax.show()
	else:
		$Rotation/ButtonUpgradeRotation.disabled = false


func _on_button_upgrade_speed_bullet_pressed():
	if speed_bullet_level < max_speed_bullet_level:
		if check_wallet(speed_bullet_cost):
			get_parent().set_XP_lable(get_parent().xp_base - speed_bullet_cost)
			speed_bullet_level += 1
			get_parent().get_node("Turel").update_bullet_speed(speed_bullet_level)
			speed_bullet_cost *= 2
			
			set_text_levels()
			set_text_cost()
		if speed_bullet_level == max_speed_bullet_level:
			$SpeedBullet/LabelMax.show()
	else:
		$SpeedBullet/ButtonUpgradeSpeedBullet.disabled = false

func _on_button_upgrade_damage_pressed():
	if damage_level < max_damade_level:
		if check_wallet(damage_cost):
			get_parent().set_XP_lable(get_parent().xp_base - damage_cost)
			damage_level += 1
			get_parent().get_node("Turel").update_damage(damage_level)
			damage_cost *= 2
			
			set_text_levels()
			set_text_cost()
		if damage_level == max_damade_level:
			$Damage/LabelMax.show()
	else:
		$Damage/ButtonUpgradeDamage.disabled = false


func _on_button_upgrade_reload_pressed():
	if reload_level < max_reload_level:
		if check_wallet(reload_cost):
			get_parent().set_XP_lable(get_parent().xp_base - reload_cost)
			reload_level += 1
			get_parent().get_node("Turel").update_reload(reload_level)
			reload_cost *= 2
			
			set_text_levels()
			set_text_cost()
		if reload_level == max_reload_level:
			$Reload/LabelMax.show()
	else:
		$Reload/ButtonUpgradeReload.disabled = false
