extends Node2D

@export var rotation_speed = 5
@export var reload = 0.5
@export var damage = 5.0
@export var speed_bullet = 400
@export var num_sprite = 1

@export var bullet_scene: PackedScene

var flag_rotate = true
var flag_gun = true

func _ready():
	$TimerShoot.wait_time = reload


func _process(delta):
	if flag_rotate:
		rotate_by_mouse(delta)

func rotate_by_mouse(delta):
	var mouse_pos = get_global_mouse_position() 
	var gun_dir = $Gun.global_position.direction_to(mouse_pos)
	var gun_angle = atan2(gun_dir.y, gun_dir.x) + PI/2
	$Gun.rotation = lerp_angle($Gun.rotation, gun_angle, delta * rotation_speed)


func _on_timer_shoot_timeout():
	if flag_gun:
		spawn_bullet()
		$Gun.frame = 0
		$Gun.play()
		$TimerShoot.start()
	
func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	var offset = Vector2(0, -120).rotated($Gun.rotation)
	var new_pos = $Gun.global_position + offset
	var new_dir = $Gun.rotation
	get_parent().add_child(bullet)
	
	bullet.create(new_pos, new_dir, damage, speed_bullet, num_sprite)
	
func start_shooting():
	$TimerShoot.start()
	
func update_rotation(level):
	rotation_speed = level * 4
	
func update_damage(level):
	num_sprite += 1
	damage = level * 4.0

func update_bullet_speed(level):
	speed_bullet = level * 600
	
func update_reload(_level):
	if reload >= 0.06:
		reload -= 0.05
		$TimerShoot.wait_time = reload
	
