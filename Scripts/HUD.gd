extends CanvasLayer


signal game_over
signal use_move_vector

var joystick_active = false
var move_vector = Vector2.ZERO

func _ready():
	GLOBAL.score = 0
	GLOBAL.level = 1
	GLOBAL.status = 'in_game'
	$InstructionsTimer.start()
	

func _physics_process(delta):
	$MarginContainer/VBoxContainer/HBoxContainer/Score.text = str(GLOBAL.score)	
	$MarginContainer/VBoxContainer/HBoxContainer2/Level.text = str(GLOBAL.level)
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $Controls/TouchScreenButton.is_pressed():
			move_vector = calculate_move_vector(event.position)
			$Controls/InnerJoy.position = event.position			
			$Controls/InnerJoy.visible = true
			joystick_active = true
		if $Controls/ActionButton.is_pressed():
			$Controls/ActionButton.modulate = Color(1,1,1,0.8)
			
	if event is InputEventScreenTouch:
		if event.pressed == false:
			move_vector = Vector2.ZERO
			$Controls/InnerJoy.visible = false
			$Controls/ActionButton.modulate = Color(1,1,1,0.3)
			#joystick_active = false 
			
func calculate_move_vector(event_position):
	var texture_center = $Controls/TouchScreenButton.position + Vector2(100, 100)
	return (event_position - texture_center).normalized()
	
func game_over():
	emit_signal("game_over")	
	$GameOverContainer.visible = true
	GLOBAL.status = 'game_over'
	$BGMusic.play()

func _on_Restart_pressed():
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Player_tree_exiting():
	game_over()


func _on_InstructionsTimer_timeout():
	$Instructions.visible = false
