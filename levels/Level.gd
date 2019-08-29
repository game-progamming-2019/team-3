extends Node

var max_score = 0
var score = 0

# Level testen - Szene - Rechtsklick - Diese Szene abspielen

# Bird an Slingshot festbinden
# Darf nur einen Bird geben
# Name muss Birds -> Bird sein
func _ready():
	$Birds/Bird.attach_to($Slingshot)
	
	for damageable in get_tree().get_nodes_in_group("Damageable"):
		damageable.connect("exploded", self, "on_Damageable_exploded")
		#max_score += max(damageable.destroy_points, damageable.survive_points)
		max_score += max(200, 800)
		
	$GUI.set_max_score(max_score)

func on_Damageable_exploded(damageable):
	#score += damageable.destroy_points
	score += 500
	$GUI.set_score(score)