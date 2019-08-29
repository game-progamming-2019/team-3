extends Node

var max_score = 0
var score = 0
var alive_birds

# Level testen - Szene - Rechtsklick - Diese Szene abspielen

# Bird an Slingshot festbinden
# Darf nur einen Bird geben
# Name muss Birds -> Bird sein
func _ready():
	$Birds/Bird.attach_to($Slingshot)
	
	for damageable in get_tree().get_nodes_in_group("Damageable"):
		damageable.connect("exploded", self, "_on_Damageable_exploded")
		#max_score += max(damageable.destroy_points, damageable.survive_points)
		max_score += max(200, 800)
	
	alive_birds = get_tree().get_nodes_in_group("Bird")
	
	change_bird()
	
	$GUI.set_max_score(max_score)

func _on_Damageable_exploded(damageable):
	#score += damageable.destroy_points
	score += 500
	$GUI.set_score(score)
	yield(get_tree(), "idle_frame")
	var ennemies = get_tree().get_nodes_in_group("Ennemy")
	if ennemies.size() == 0:
		prepare_end()

func _on_Bird_eliminated(bird):
	var current_bird = change_bird()
	if ! current_bird:
		prepare_end()
		
func change_bird():
	if alive_birds.size() == 0:
		return null
	var current_bird = alive_birds.pop_front()
	current_bird.connect("eliminated", self, "_on_Bird_eliminated")
	current_bird.attach_to($Slingshot)
	return current_bird

func prepare_end():
	$GUI.display_end_button()