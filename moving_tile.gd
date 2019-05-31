extends KinematicBody2D

# Declare member variables here. Examples:
export var speed = 3
export var move_to = Vector2(128 * 4, 0)
export var idle_delay = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	move()

func move():
	$Tween.interpolate_property(self, "position", global_position, global_position + move_to, speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT, idle_delay)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	move_to *= -1
	move()
