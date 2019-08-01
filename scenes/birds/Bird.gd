extends "res://scenes/Damageable.gd"

# Definition Status von Bird
enum {
	STATE_IDLE,
	STATE_TRANSFERED,
	STATE_ATTACHED,
	STATE_DRAGGED,
	STATE_RELEASED,
	STATE_LAUNCHED
}

var state = STATE_IDLE
var impulse = null
var slingshot = null

# Geschwindigkeit von Bird zu Slingshot
export(int, 60, 600) var TRANSFER_SPEED = 300

func _integrate_forces(s):
	# Damageable - integrate forces
	._integrate_forces(s)
	if s.get_contact_count() > 0 and state == STATE_LAUNCHED:
		state = STATE_IDLE
	var launch_pos = slingshot.get_node("LaunchPoint").get_global_position()
	var diff_pos = launch_pos - get_global_position()
	if Input.is_action_just_released("touch") and state == STATE_DRAGGED:
		# Geschwindigkeit von Bird bei Abschuss - Impulse - Faktor 0.6 ganz schnell - 0.06 langsamer
		impulse = diff_pos * 0.17
		# Klappt noch nicht
		#impulse = slingshot.get_impulse()
		#print(impulse)
		state = STATE_RELEASED if impulse.x > 0 else STATE_ATTACHED
	var lv = s.get_linear_velocity()
	var av = s.get_angular_velocity()
	var delta = 1 / s.get_step()
	
	# IMPLEMENT STATES
	match state:
		# Bird nach Slingshot bewegen
		STATE_TRANSFERED:
			if diff_pos.length() < TRANSFER_SPEED:
				lv = diff_pos * delta
				state = STATE_ATTACHED
				slingshot.attach_bird(self)
			else:
				lv = diff_pos.normalized() * TRANSFER_SPEED * delta
		# Bird bleibt an Slingshot kleben
		STATE_ATTACHED:
			lv = diff_pos * delta * 0.3
			av = -rotation * delta
		# Bird per linker Maustaste bewegen
		STATE_DRAGGED:
			var player_force = get_global_mouse_position() - launch_pos
			var angle = diff_pos.angle()
			av = (angle - rotation) * delta
			if angle < -1.2 and angle > -2:
				player_force = player_force.clamped(10)
			else:
				# Weite des Aufzugs der Slingshot
				player_force = player_force.clamped(100)
			lv = (player_force + diff_pos) * 0.3 * delta
		# Physik bei loslassen der linken Maustaste
		STATE_RELEASED:
			if diff_pos.length() < impulse.length():
				state = STATE_LAUNCHED
				slingshot.detach_bird()
			else:
				lv = impulse * delta
		# Rotation Bird im Flug
		STATE_LAUNCHED:
			av = (lv.angle() - rotation) * delta
			
	s.set_linear_velocity(lv)
	s.set_angular_velocity(av)
	
func attach_to(slingshot):
	self.slingshot = slingshot
	state = STATE_TRANSFERED
	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("touch") and state == STATE_ATTACHED:
		state = STATE_DRAGGED 