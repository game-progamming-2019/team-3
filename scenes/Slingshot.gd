extends Node2D

var bird

# Slingshot aufziehen Textur
func _process(delta):
	update_elastic($ElasticBack)
	update_elastic($ElasticFront)
	
# Je nach Aufzug der Slingshot die Textur anpassen
func update_elastic(elastic):
	var attach_pos = self.bird.get_node("AttachPoint").get_global_position() if self.bird else $LaunchPoint.get_global_position()
	var diff_pos = attach_pos - elastic.get_node("FixationPoint").get_global_position()
	var middle = diff_pos / 2
	var sprite = elastic.get_node("Sprite")
	sprite.position = middle
	sprite.scale.x = - middle.length() * 0.01
	sprite.rotation = middle.angle()
	
func attach_bird(bird):
	self.bird = bird
	
func detach_bird():
	self.bird = null