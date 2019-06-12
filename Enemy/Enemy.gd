extends KinematicBody2D

class_name Enemy

enum ENEMIES {BAT,RAT}

export(ENEMIES) var id = ENEMIES.BAT

export var distance = 100
export var speed = 100
export var direction : Vector2 = Vector2(1,0)

var json
var movement
var frozen = false

onready var collision = $Collision
onready var sprite = $Sprite
onready var timer = $Timer
onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Enemy/enemies.json",file.READ)
	json = parse_json(file.get_as_text())
	get_node("/root/World/DayNight").connect("_freeze_enemies", self, "freeze")
	get_node("/root/World/DayNight").connect("_unfreeze_enemies", self, "unfreeze")
	get_node("/root/World/Player").connect("_on_flashlight_entered", self, "flee")
	get_node("/root/World/Player").connect("_on_enemy_touched", self, "touched")
	createEnemy()

func createEnemy():
	sprite.flip_h = true
	sprite.texture = load("res://Enemy/Sprites/" + json["enemies"][id]["Texture"]["File"])
	#sprite.region_enabled  = true
	#sprite.region_rect.position.x = json["enemies"][id]["Texture"]["region"]["x"]
	#prite.region_rect.position.y = json["enemies"][id]["Texture"]["region"]["y"]
	#sprite.region_rect.size.x = json["enemies"][id]["Texture"]["region"]["w"]
	#sprite.region_rect.size.y = json["enemies"][id]["Texture"]["region"]["h"]

	collision.shape.extents.x = json["enemies"][id]["Collision"]["size"]["x"]
	collision.shape.extents.y = json["enemies"][id]["Collision"]["size"]["y"]
	collision.position.x = json["enemies"][id]["Collision"]["position"]["x"]
	collision.position.y = json["enemies"][id]["Collision"]["position"]["y"]
	
	self.scale = Vector2(2, 2)
	
	if(json["enemies"][id]["Movement"] == "linear"):
		movement = LinearMovement.new()
		
	elif(json["enemies"][id]["Movement"] == "sine"):
		movement = SineMovement.new()
		
	add_child(movement)
		
	if id == ENEMIES.BAT:
		animPlayer.play("bat")
	elif id == ENEMIES.RAT:
		animPlayer.play("rat")

func freeze(timed = false):
	frozen = true
	movement.freeze()
	animPlayer.stop(false)
	
func unfreeze():
	frozen = false
	movement.unfreeze()
	animPlayer.play()
	
func flee(body):
	if body == self:
		print(self.name)
		
func touched(body, player):
	if body == self && frozen == false:
		player.respawn()