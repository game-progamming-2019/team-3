extends Camera2D

# Mittlere Maustaste gedrückt halten und ziehen  -> Mit der Kamera über die Map schweben
# drag_cam unter Projekteinstellungen -> Input Map gesetzt

var drag_cam = false
var old_mouse_pos

func _ready():
	pass 

func _process(delta):
	
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("drag_cam"):
		drag_cam = true
		old_mouse_pos = mouse_pos
	
	if Input.is_action_just_released("drag_cam"):
		drag_cam = false
		
	if drag_cam:
		var mouse_move = old_mouse_pos - mouse_pos
		position = position + mouse_move
		old_mouse_pos = mouse_pos