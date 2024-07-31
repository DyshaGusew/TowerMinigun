extends Area2D

signal died(monster)
signal died_bullet_monster(XP)
signal damage_defence(damage)

@export var HP = 25
@export var XP = 5
@export var damage = 3
@export var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# gets the angle we want to face
	var to_player = global_position.direction_to(get_parent().find_child("Turel").position)
	position += to_player * speed
	


func _on_area_entered(area):
	if area.is_in_group("Bullets"):
		HP -= area.damage
		if HP <= 0:
			bullet_on_monster()
		area.queue_free()
	if area.name == "Defence":
		damage_on_defence()
		
		
func damage_on_defence():
	damage_defence.emit(damage)
	died.emit(self)


func bullet_on_monster():
	died_bullet_monster.emit(XP)
	died.emit(self)

