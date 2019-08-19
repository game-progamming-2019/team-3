extends Node2D


func _on_Play_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.campain_menu()
		
func campain_menu():
	get_tree().change_scene("res://levels/CampainMenu.tscn")


func _on_Quit_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.quit_game()
		
func quit_game():
	get_tree().quit()