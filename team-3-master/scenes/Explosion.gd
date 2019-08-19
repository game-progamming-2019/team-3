extends Sprite

func _ready():
	# Animation abspielen
	$AnimationPlayer.play("default")
	# Signal finished senden
	yield($AnimationPlayer, "animation_finished");
	# Animation beenden
	queue_free()