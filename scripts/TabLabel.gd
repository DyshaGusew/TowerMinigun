extends Label

var alpha = 1.0
var flag_up = false
@export var speed_changing = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag_up:
		alpha += speed_changing * delta
		if alpha >= 0.95:
			flag_up = false
	else:
		alpha -= speed_changing * delta
		if alpha <= 0.05:
			flag_up = true
		
	add_theme_color_override("font_color", Color(1, 1, 1, alpha))
