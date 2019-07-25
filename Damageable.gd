extends RigidBody2D

# Damageable Klasse ist fuer alle Elemente (Birds, Enemies, Blocks), 
# welche eine Lebensanzeige besitzen und zerstoert werden koennen

# health variable fuer jedes einzelne Element
export(int, 1, 1000) var health = 10
var processed_velocity = Vector2()
var processed_angular_velocity = Vector2()

func _physics_process(delta):
	self.processed_velocity = self.linear_velocity
	self.processed_angular_velocity = self.processed_angular_velocity
	
func _integrate_forces(state):
	var contact_counts = {}
	for i in range(0, state.get_contact_count()):
		var contact_id = state.get_contact_collider_id(i)
		if not contact_counts.has(contact_id):
			contact_counts[contact_id] = 1
		else:
			contact_counts[contact_id] += 1
	
	for i in range(0, state.get_contact_count()):
		var contact = state.get_contact_collider_object(i)
		var contact_velocity = state.get_contact_collider_velocity_at_position(i)
		var R = self.global_position - state.get_contact_local_position(i)
		var self_velocity = self.processed_velocity - self.processed_angular_velocity * Vector2(-R.y, R.x)
		var v = contact_velocity - self_velocity
		var m_self = self.mass
		var m_contact = contact.mass if contact is RigidBody2D else 100000000
		var p = v.dot(state.get_contact_local_normal(i)) * (m_contact / (m_self + m_contact))
		get_damage(p * 0.05)
	
func _on_Damageable_body_entered(body):
	# Erkennung einer Kollision zwischen einzelnen Elementen
	# RigidBody Settings - Contact Monitor / Contacts Reported
	#print("Damage Collision detected")
	#get_damage(self.processed_velocity.length() * 0.05)
	pass
	
func get_damage(damage):
	# Damage von Health abziehen und ggf Element loeschen
	damage = round(damage)
	if damage > 0:
		print("damage: ", damage)
		self.health -= damage
		if self.health <= 0:
			queue_free()