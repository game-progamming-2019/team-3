extends CanvasLayer

var count = 0

func _ready():
	pass # Replace with function body.

func _on_Battery_body_entered(body):
	if body.get_name() == "Player":
		count += 1
		$Control/CoinCount.text = String(count)
	pass # Replace with function body.