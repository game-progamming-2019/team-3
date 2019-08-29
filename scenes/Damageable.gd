extends RigidBody2D

# Damageable Klasse ist fuer alle Elemente (Birds, Enemies, Blocks), 
# welche eine Lebensanzeige besitzen und zerstoert werden koennen

# health variable fuer jedes einzelne Element
# Kann manuell im Level fuer jedes Objekt angepasst werden, da Export Variable
export(int, 1, 1000) var health = 10
# Explosion Szene laden wenn Health < 0
export(PackedScene) var explosion_scene: PackedScene = preload("res://scenes/Explosion.tscn")
export(int, 0, 100000) var destroy_points = 500
export(int, 0, 100000) var survive_points = 0
var processed_velocity = Vector2()
var processed_angular_velocity = Vector2()
onready var max_health = health

signal exploded

# Beeinflusst Physic
func _physics_process(delta):
	self.processed_velocity = self.linear_velocity
	self.processed_angular_velocity = self.processed_angular_velocity
	
# Zugriff auf Physics2DDirectBodyState - angular_velocity Funktionen
func _integrate_forces(state):
	# Kontakte von Bird mit anderen Objekten
	var contact_counts = {}
	for i in range(0, state.get_contact_count()):
		var contact_id = state.get_contact_collider_id(i)
		if not contact_counts.has(contact_id):
			contact_counts[contact_id] = 1
		else:
			contact_counts[contact_id] += 1
	
	# Fuer jeden Kontakt Damage ermitteln und abziehen
	for i in range(0, state.get_contact_count()):
		var contact = state.get_contact_collider_object(i)
		var contact_velocity = state.get_contact_collider_velocity_at_position(i)
		var R = self.global_position - state.get_contact_local_position(i)
		var self_velocity = self.processed_velocity - self.processed_angular_velocity * Vector2(-R.y, R.x)
		var v = contact_velocity - self_velocity
		var m_self = self.mass
		var m_contact = contact.mass if contact is RigidBody2D else 100000000
		var p = v.dot(state.get_contact_local_normal(i)) * (m_contact / (m_self + m_contact))
		get_damage(p * 0.06)
	
func get_damage(damage):
	# Damage von Health abziehen und ggf Element loeschen
	damage = round(damage)
	if damage > 0:
		self.health -= damage
		
		print("damage: ", damage)
		print("health: ", self.health)
		
		# Animation aktualisieren, da Lebensanzeige sich aendert
		# Bird bekommt blaues Auge - andere Animation
		update_animation()
		
		# Wenn Leben aufgebraucht
		if self.health <= 0:
			explode()
	
# Animation von Bird / LittleGreen
# 1_weak - Zwei Augen blau
# 2_average - Ein Auge blau
# 3_healthy - Kein Auge blau
func update_animation():
	# ggf Elemente in Szene, die nicht animiert sind
	if $AnimationPlayer:
		print("if")
		if $AnimationPlayer.get_animation_list().size() > 0:
			# Health Rate berechnen - 0.2
			var h_ratio = float(health) / float(max_health)
			# Ceil aufrunden - Floor abrunden
			var current_animation_index = ceil(h_ratio * $AnimationPlayer.get_animation_list().size()) - 1
			$AnimationPlayer.play($AnimationPlayer.get_animation_list()[current_animation_index])

func explode():
	# Objekt explodieren lassen durch Animation
	var explosion = explosion_scene.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	emit_signal("exploded", self)
	# Objekt loeschen
	queue_free()