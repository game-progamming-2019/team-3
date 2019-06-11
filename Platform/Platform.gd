extends KinematicBody2D

export var speed = 3
export var move_to = Vector2(32 * 5, 0)
export var idle_delay = 0.5

func _ready():
	move()
	
func move():
	$Tween.interpolate_property(self, "position", global_position, global_position + move_to, speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT, idle_delay)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	move_to *= -1 #revert direction
	move()