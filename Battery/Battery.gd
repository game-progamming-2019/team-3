extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Coin_body_entered(body):
	if body.get_name() == "Player":
		queue_free()
	pass # Replace with function body.
