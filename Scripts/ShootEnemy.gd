extends Area2D

onready var player : KinematicBody2D = get_tree().get_nodes_in_group("player")[0]

const SPEED = 300

func _ready():
	#player.can_shoot = false	
	$ShootSound.play()
	
func _physics_process(delta):
	if GLOBAL.level == 1:
		position.y += 300 * delta
	if GLOBAL.level == 2:
		position.y += 400 * delta
	if GLOBAL.level == 3:
		position.y += 500 * delta
	if GLOBAL.level == 4:
		position.y += 600 * delta
	if GLOBAL.level == 5:
		position.y += 650 * delta
	


func _on_Shoot_area_entered(area):
	if area.is_in_group("player"):
		queue_free()




func _on_VisibilityNotifier2D_screen_exited():
	if is_instance_valid(player):
		player.can_shoot = true
	queue_free()	


func _on_ShootEnemy_body_entered(body):
	if body.is_in_group("player"):		
		queue_free()		
		body.queue_free()		
