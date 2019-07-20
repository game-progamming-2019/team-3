extends RigidBody2D

# Damageable Klasse ist fuer alle Elemente (Birds, Enemies, Blocks), 
# welche eine Lebensanzeige besitzen und zerstoert werden koennen

# health variable fuer jedes einzelne Element
export(int, 1, 1000) var health = 10
var processed_velocity = Vector2()

func _physics_process(delta):
	self.processed_velocity = self.linear_velocity
	
func _on_Damageable_body_entered(body):
	# Erkennung einer Kollision zwischen einzelnen Elementen
	# RigidBody Settings - Contact Monitor / Contacts Reported
	print("Damage Collision detected")
	get_damage(self.processed_velocity.length() * 0.05)
	
func get_damage(damage):
	# Damage von Health abziehen und ggf Element loeschen
	print("damage: ", damage)
	self.health -= damage
	if self.health <= 0:
		queue_free()