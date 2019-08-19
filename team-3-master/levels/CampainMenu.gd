extends Node2D

func _on_Level1_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level1()
		
func start_level1():
	get_tree().change_scene("res://levels/Level1.tscn")

func _on_Level2_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level2()
		
func start_level2():
	get_tree().change_scene("res://levels/Level2.tscn")

func _on_Level3_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level3()
		
func start_level3():
	get_tree().change_scene("res://levels/Level3.tscn")

func _on_Level4_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level4()
		
func start_level4():
	get_tree().change_scene("res://levels/Level4.tscn")

func _on_Level5_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level5()
		
func start_level5():
	get_tree().change_scene("res://levels/Level5.tscn")
	

func _on_Level6_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level6()
		
func start_level6():
	get_tree().change_scene("res://levels/Level6.tscn")
	

func _on_Level7_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level7()
		
func start_level7():
	get_tree().change_scene("res://levels/Level7.tscn")
	
	
func _on_Level8_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level8()
		
func start_level8():
	get_tree().change_scene("res://levels/Level8.tscn")
	

func _on_Level9_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level9()
		
func start_level9():
	get_tree().change_scene("res://levels/Level9.tscn")
	


func _on_Level10_Selection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.start_level10()
		
func start_level10():
	get_tree().change_scene("res://levels/Level10.tscn")
	

func _on_Back_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
		self.back_to_main_menu()
		
func back_to_main_menu():
	get_tree().change_scene("res://levels/MainMenu.tscn")
