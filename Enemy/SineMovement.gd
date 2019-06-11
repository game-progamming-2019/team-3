extends Node2D

class_name SineMovement

var ticks = 0
var travelDistance = 0
var parent
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	sprite = get_node("../Sprite")
	pass # Replace with function body.

func _physics_process(delta):
	ticks += delta
	travelDistance += parent.speed * delta
	
	if(travelDistance > parent.distance):
		travelDistance = 0		
		sprite.flip_h = !sprite.flip_h
		parent.direction *= -1
	
	parent.position.x += parent.direction.x * parent.speed * delta
	parent.position.y += sin(ticks * 5) * 2.2
	
	pass
