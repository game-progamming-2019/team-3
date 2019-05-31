extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()
var speed = 300
var gravity = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	
	direction = Vector2()
	
	if Input.is_key_pressed(KEY_D):
		direction.x = speed
	if Input.is_key_pressed(KEY_A):
		direction.x = -speed
	if Input.is_key_pressed(KEY_SPACE) && is_on_floor():
		velocity.y -= 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity.x = direction.x
	velocity.y += gravity * delta
	
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
