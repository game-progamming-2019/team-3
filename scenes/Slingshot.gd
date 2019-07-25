extends Node2D

var bird

func _process(delta):
	update_elastics($ElasticBack)
	update_elastics($ElasticFront)
	
func update_elastics(elastic):
	var attach_pos = self.bird.get_node("AttachPoint").get_global_position() if self.bird else $LaunchPoint.get_global_position()
	var diff_pos = attach_pos - elastic.get_node("FixationPoint").get_global_position()
	var middle = diff_pos / 2
	var sprite = elastic.get_node("Sprite")
	sprite.position = middle
	sprite.scale.x = middle.length()
	
func attach_bird(bird):
	self.bird = bird
	
func detach_bird():
	self.bird = null