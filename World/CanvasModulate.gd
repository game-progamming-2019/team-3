extends CanvasModulate

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	light()
	

func light():
	$Tween.interpolate_property(self, "color", Color(1.0, 1.0, 1.0), Color(0.2, 0.2, 0.2), 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
