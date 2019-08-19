# tool - Anzeige von Flugbahn im 2D Editor
tool
extends Node2D

var bird
# Script von Bird vorladen fuer Zugriff auf Status
var BirdScript = preload("res://scenes/birds/Bird.gd")

# Trajectory - Anzeige der Flugbahn
export(int, 5, 15) var TRAJECTORY_SPOT_COUNT = 10
export(float, 0.2, 1, 0.1) var TRAJECTORY_TIME_STEP = 0.5
export(int, 1, 10) var STRENGTH = 5
export(int, 10, 100) var TRAJECTORY_IMPULSE = 75
export(int, -90, 90) var TRAJECTORY_ANGLE = 45
# Sichtbarkeit Fluganzeige im Editor
export(bool) var TRAJECTORY_VISIBILITY = true
# Spot Szene ist ein einzelner Punkt der Flugbahnanzeige
export(PackedScene) var spot_scene

func _ready():
	$Trajectory.position = $LaunchPoint.position

# Slingshot aufziehen Textur
func _process(delta):
	for spot in $Trajectory.get_children():
		spot.queue_free()
	
	# Anzeige Flugbahn 2D Editor
	if Engine.is_editor_hint() and TRAJECTORY_VISIBILITY:
		draw_trajectory_for_impulse(Vector2(TRAJECTORY_IMPULSE * STRENGTH, 0).rotated(deg2rad(-TRAJECTORY_ANGLE)))
	else:
		# Textur Anpassen
		update_elastic($ElasticBack)
		update_elastic($ElasticFront)
		var impulse = get_impulse()
		# Bei Aufzug der Slingshot Flugbahn anzeigen lassen
		if self.bird and self.bird.state == BirdScript.STATE_DRAGGED and impulse.x > 0:
			draw_trajectory_for_impulse(impulse)
	
# Je nach Aufzug der Slingshot die Textur anpassen - Mausposition
func update_elastic(elastic):
	var attach_pos = self.bird.get_node("AttachPoint").get_global_position() if self.bird else $LaunchPoint.get_global_position()
	var diff_pos = attach_pos - elastic.get_node("FixationPoint").get_global_position()
	var middle = diff_pos / 2
	var sprite = elastic.get_node("Sprite")
	sprite.position = middle
	sprite.scale.x = - middle.length() * 0.01
	sprite.rotation = middle.angle()
	
# Bird an Slingshot koppeln
func attach_bird(bird):
	self.bird = bird
	
# Bird nach Start von Slingshot entkoppeln
func detach_bird():
	self.bird = null
	
func get_impulse():
	if ! self.bird:
		return null
	
	# Ermittlung von Staerke des Flugstarts
	# Je weiter der Aufzug der Slingshot, desto weiter der Flug
	return($LaunchPoint.global_position - self.bird.global_position) * STRENGTH
	
func draw_trajectory_for_impulse(impulse):
	# Allgemein - Physics - 2D - Gravity
	var gravity = ProjectSettings.get("physics/2d/default_gravity")
	for i in range(0, TRAJECTORY_SPOT_COUNT):
		var t = i * TRAJECTORY_TIME_STEP
		var x = impulse.x * t
		var y = gravity * t * t/2 + impulse.y * t
		draw_spot(Vector2(x,y))
		
# Einzelner Punkt von Flugbahnanzeige instanziieren
func draw_spot(position):
	var spot = spot_scene.instance()
	spot.position = position
	$Trajectory.add_child(spot)