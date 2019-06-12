extends KinematicBody2D

class_name Enemy

enum ENEMIES {BAT,RAT}

export(ENEMIES) var id = ENEMIES.BAT

var distance = 100
var speed = 100
var direction : Vector2 = Vector2(1,0)

var json

onready var collision = $Collision
onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Enemy/enemies.json",file.READ)
	json = parse_json(file.get_as_text())
	createEnemy()


func createEnemy():
	sprite.texture = load("res://Enemy/Sprites/" + json["enemies"][id]["Texture"]["File"])
	sprite.region_enabled  = true
	sprite.region_rect.position.x = json["enemies"][id]["Texture"]["region"]["x"]
	sprite.region_rect.position.y = json["enemies"][id]["Texture"]["region"]["y"]
	sprite.region_rect.size.x = json["enemies"][id]["Texture"]["region"]["w"]
	sprite.region_rect.size.y = json["enemies"][id]["Texture"]["region"]["h"]

	collision.shape.extents.x = json["enemies"][id]["Collision"]["size"]["x"]
	collision.shape.extents.y = json["enemies"][id]["Collision"]["size"]["y"]
	
	self.scale = Vector2(2, 2)
	
	if(json["enemies"][id]["Movement"] == "linear"):
		add_child(LinearMovement.new())
	elif(json["enemies"][id]["Movement"] == "sine"):
		add_child(SineMovement.new())
