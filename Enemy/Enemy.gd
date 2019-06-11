extends KinematicBody2D

class_name Enemy

enum ENEMIES {BAT,RAT}

export(ENEMIES) var id = ENEMIES.BAT

var distance = 100
var speed = 100
var direction : Vector2 = Vector2(1,0)

var json

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Enemy/enemies.json",file.READ)
	json = parse_json(file.get_as_text())
	createEnemy()



func createEnemy():
	$Sprite.texture = load("res://Enemy/Sprites/" + json["enemies"][id]["Texture"][0]["File"])
	$Sprite.region_enabled  = true
	$Sprite.region_rect.position.x = json["enemies"][id]["Texture"][0]["region"][0]["x"]
	$Sprite.region_rect.position.y = json["enemies"][id]["Texture"][0]["region"][0]["y"]
	$Sprite.region_rect.size.x = json["enemies"][id]["Texture"][0]["region"][0]["w"]
	$Sprite.region_rect.size.y = json["enemies"][id]["Texture"][0]["region"][0]["h"]
	$Sprite.scale = Vector2(2.0,2.0)
	$Sprite.position = get_parent().position 
	
	if(json["enemies"][id]["Movement"] == "linear"):
		#var scene = load("res://LinearMovement.tscn")
		#add_child(scene.instance())
		add_child(LinearMovement.new())
	elif(json["enemies"][id]["Movement"] == "sine"):
		add_child(SineMovement.new())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
