extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var Shoot
var speed

func _ready():	
	$AnimatedSprite.play()		
	if GLOBAL.level == 1:
		speed = GLOBAL.random(32, 42)		
		$ShootTimer.wait_time = 2
	if GLOBAL.level == 2:
		speed = GLOBAL.random(102, 212)
		$ShootTimer.wait_time = 2
	if GLOBAL.level == 3:
		speed = GLOBAL.random(202, 312)	
		$ShootTimer.wait_time = 1
	if GLOBAL.level == 4:
		speed = GLOBAL.random(300, 412)	
		$ShootTimer.wait_time = 1
	if GLOBAL.level == 5:
		speed = GLOBAL.random(300, 612)	
		$ShootTimer.wait_time = 0.8
	$ShootTimer.start()	
	
func _physics_process(delta):
	position.y += speed * delta
	
func death_enemy():
	queue_free()
	explosion_ctrl()
	
func shoot_ctrl():
	var shoot = Shoot.instance()
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("level", "add_child", shoot)
	
func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", explosion)


func _on_Enemy1_body_entered(body):
	if body.is_in_group("player"):
		death_enemy()
		body.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy1_area_entered(area):
	if area.is_in_group("shoot"):
		death_enemy()
		GLOBAL.score += 10


func _on_ShootTimer_timeout():	
	if GLOBAL.status != "game_over":
		shoot_ctrl()
