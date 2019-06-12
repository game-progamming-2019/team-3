extends CanvasModulate

signal _freeze_enemies
signal _unfreeze_enemies

var start_Color = Color(1.0, 1.0, 1.0)
var end_Color = Color (0.2, 0.2, 0.2)
var night = true
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
	night = !night	
	light()

func _on_Tween_tween_completed(object, key):
	if night == true:
		emit_signal("_unfreeze_enemies")
	else:
		emit_signal("_freeze_enemies")
	
	pass # Replace with function body.
