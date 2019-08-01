extends Camera2D

# Mittlere Maustaste gedrückt halten und ziehen  -> Mit der Kamera über die Map schweben
# drag_cam unter Projekteinstellungen -> Input Map gesetzt

# Mausrad Scrollen - Zoom in und out
# zoom_in zoom_out - Input Map

var drag_cam = false
var old_mouse_pos

export(int) var CAMERA_SPEED = 2
export(float, 0.5, 5) var zoom_min = 1
export(float, 2, 10) var zoom_max = 2
export(int, 1, 10) var zoom_speed = 2

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
	
func _input(event):
	var z = zoom.x
	if event.is_action("zoom_in"):
		z += 0.01 * zoom_speed
	if event.is_action("zoom_out"):
		z -= 0.01 * zoom_speed
	
	z = clamp(z, zoom_min, zoom_max)
	
	zoom = Vector2(z,z)