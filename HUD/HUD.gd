extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _process(delta):
	$Control/CoinCount.text = String(global.battery_count)