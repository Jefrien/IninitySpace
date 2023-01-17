extends Control


func _ready():
	$BGMusic.play()

func _physics_process(delta):
	$Stars.scroll_base_offset += Vector2(0, 1) * 32 * delta


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Level.tscn")
