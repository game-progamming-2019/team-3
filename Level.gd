extends Node

# Bird an Slingshot festbinden
func _ready():
	$Birds/Bird.attach_to($Slingshot)
