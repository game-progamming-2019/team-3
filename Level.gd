extends Node

# Level testen - Szene - Rechtsklick - Diese Szene abspielen

# Bird an Slingshot festbinden
# Darf nur einen Bird geben
# Name muss Birds -> Bird sein
func _ready():
	$Birds/Bird.attach_to($Slingshot)