extends Area2D

onready var player : KinematicBody2D = get_tree().get_nodes_in_group("player")[0]

const SPEED = 500

func _ready():
	#player.can_shoot = false	
	$ShootSound.play()
	
func _physics_process(delta):
	position.y -= SPEED * delta


func _on_Shoot_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()




func _on_VisibilityNotifier2D_screen_exited():
	if is_instance_valid(player):
		player.can_shoot = true
	queue_free()	
