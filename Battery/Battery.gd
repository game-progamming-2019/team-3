extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
		if global.battery_count >= global.battery_max_count:
			global.battery_count = global.battery_max_count
		else:
			global.battery_count += 1
			queue_free()
