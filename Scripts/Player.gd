extends KinematicBody2D

export (PackedScene) var Shoot

const SPEED = 300
onready var motion = Vector2.ZERO
onready var can_shoot : bool = true
onready var screensize = get_viewport_rect().size
onready var mVector = Vector2.ZERO
var mDelta = 0
var pressJoy = false

func _ready():
	$AirShip.frame = 1
	
func _physics_process(delta):
	motion_ctrl()
	animation_ctrl()
	mDelta = delta
	move_and_collide(mVector * mDelta)
	#motion = move_and_collide(mVector * delta)
	
func _input(event):
	if event.is_action_pressed("ui_accept") and can_shoot:
		shoot_ctrl()		
	if event.is_action_pressed("ui_up")	|| event.is_action_pressed("ui_right")	|| event.is_action_pressed("ui_left")	|| event.is_action_pressed("ui_down"):
		mVector = get_axis()
		
func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if pressJoy:
		return mVector
	else:		
		return axis

func motion_ctrl():	
	if get_axis() == Vector2.ZERO:
		mVector = Vector2.ZERO
	else:
		mVector = get_axis().normalized() * SPEED
			
	# limit movement of player
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	

func motion_joy_ctrl():	
	if mVector == Vector2.ZERO:
		mVector = Vector2.ZERO
	else:
		mVector = get_axis().normalized() * SPEED
			
	# limit movement of player
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
func animation_ctrl():
	if mVector.x > 0:
		$AirShip.frame = 2
		$AirShip/Boost.visible = false
		$AirShip/BoostRight.visible = true
		$AirShip/BoostLeft.visible = false
	elif mVector.x < 0:
		$AirShip.frame = 0
		$AirShip/Boost.visible = false
		$AirShip/BoostRight.visible = false
		$AirShip/BoostLeft.visible = true
	else:
		$AirShip.frame = 1
		$AirShip/Boost.visible = true
		$AirShip/BoostRight.visible = false
		$AirShip/BoostLeft.visible = false
		
func shoot_ctrl():
	var shoot = Shoot.instance()
	shoot.global_position = $SpawnShoot.global_position
	get_tree().call_group("level", "add_child", shoot)



func _on_HUD_use_move_vector(move_vector):
	# limit movement of player
	mVector = move_vector * SPEED	
	if move_vector != Vector2.ZERO:
		pressJoy = true
	else:
		pressJoy = false
	#motion_joy_ctrl()
	#animation_ctrl()
	#mVector = move_and_collide(mVector * mDelta)*/
