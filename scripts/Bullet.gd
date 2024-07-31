extends Area2D

@export var speed_bullet = 400
var damage = 5
	
var velocity = Vector2()

func update_sprite(num_sprite):
	var texture_path = "res://art//TurelComponents//Bullets/Bullet_" + str(num_sprite) + ".png"
	var new_texture = load(texture_path)
	
	if new_texture:
		$Sprite2D.texture = new_texture
	else:
		print("Ошибка загрузки текстуры: ", texture_path)
	
func create(pos, dir, _damage, _speed_bullet, num_sprite):
	rotation = dir
	position = pos
	damage = _damage
	speed_bullet = _speed_bullet
	update_sprite(num_sprite)
	velocity = Vector2(0, -speed_bullet).rotated(rotation)
	
func _process(delta):
	position += (velocity * delta)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
