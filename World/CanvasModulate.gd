extends CanvasModulate

var start_Color = Color(1.0, 1.0, 1.0)
var end_Color = Color (0.2, 0.2, 0.2)
var cache

# Called when the node enters the scene tree for the first time.
func _ready():
	light()
	

func light():
	$Tween.interpolate_property(self, "color", start_Color, end_Color, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Timer_timeout():
	cache = start_Color
	start_Color = end_Color
	end_Color = cache
	light()
