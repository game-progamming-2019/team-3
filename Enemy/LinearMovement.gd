extends Node2D

class_name LinearMovement

#var speed = 100
#var distance = 100
var direction = Vector2(1,0)
var tween
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("../Sprite")
	tween = Tween.new()
	tween.connect("tween_completed", self, "_on_Tween_tween_completed")
	add_child(tween)
	_start_tween()

func _start_tween():
	var root = get_parent()
	var duration = root.distance / root.speed
	tween.interpolate_property(root,"position", root.position, root.position + direction * root.distance, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT) 
	tween.start()

func _on_Tween_tween_completed(object, key):
	direction *= -1
	sprite.flip_h = !sprite.flip_h
	_start_tween()
	
func freeze():
	tween.set_active(false)
	pass
	
func unfreeze():
	tween.set_active(true)
	pass
