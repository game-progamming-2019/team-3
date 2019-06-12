extends KinematicBody2D

export var speed = 200
export var gravity = 36
export var jump_force = 600
export var max_on_air_time = 0.1
export var max_air_jump_count = 1
export var flashlight_uptime = 5

var direction = 0
var velocity = Vector2()
var on_air_time = 0.0
var jump_count = 0
var jumped = false

onready var flashlight = get_node("Flashlight")
onready var sprite = get_node("AnimatedSprite")

func _ready():
	$Flashlight_Uptime.wait_time = flashlight_uptime
	
func _input(event):
	if event.is_action_pressed("ui_up") && \
	(is_on_floor() || (on_air_time < max_on_air_time) || jump_count < max_air_jump_count):
		velocity.y = -jump_force
		jump_count += 1
		jumped = true
		
func get_input():
	if Input.is_action_pressed("ui_left"):
		direction = -1
		sprite.flip_h = true
		flashlight.position.x = -14
	elif Input.is_action_pressed("ui_right"):
		direction = 1
		sprite.flip_h = false
		flashlight.position.x = 14
	else:
		direction = 0
		
	if Input.is_action_just_pressed("ui_down"):
		if ($Flashlight.enabled == false && global.battery_count > 0):
			global.battery_count -= 1
			$Flashlight.enabled = true
			$Flashlight_Uptime.start()

func _process(delta):
	get_input()
	flashlight.look_at(get_global_mouse_position())
	pass
		
func _physics_process(delta):	
	if is_on_wall() == false:
		velocity.x = direction * speed
	
	#if direction == 0 && !jumped && is_on_floor() && velocity.y < 0 && test_move(self.transform, Vector2(1, 0)):
		#velocity.y = 0
	
	velocity.y += gravity
		
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		elif jumped:
			sprite.play("jump1")
		else:
			sprite.play("run");
	else:
		if velocity.y < 0 && jumped:
			sprite.play("jump2")
		else:
			if velocity.y + gravity * delta * 30 < 0:
				sprite.play("fall1")
			else:
				sprite.play("fall2")
				
	var snap = Vector2.DOWN * 32 if !jumped else Vector2.ZERO
	
	velocity = move_and_slide_with_snap(velocity, snap, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		jump_count = 0
		jumped = false
	else:
		on_air_time += delta

func _on_DeathPlane_body_entered(body):
	position = Vector2(92, 160)
	pass


func _on_Flashlight_Uptime_timeout():
	$Flashlight.enabled = false
	$Flashlight_Uptime.wait_time = flashlight_uptime
