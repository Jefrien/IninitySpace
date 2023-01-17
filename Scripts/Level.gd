extends Node2D

export (PackedScene) var Enemy

func _ready():
	$BGMusic.play()
	$EnemySpawnTimer.start()
	randomize()

func _physics_process(delta):	
	if GLOBAL.level == 1:
		$BGMusic.pitch_scale = 1
		$BG.scroll_base_offset += Vector2(0, 1) * 128 * delta
	if GLOBAL.level == 2:
		$BGMusic.pitch_scale = 1.1
		$BG.scroll_base_offset += Vector2(0, 1) * 192 * delta
	if GLOBAL.level == 3:
		$BGMusic.pitch_scale = 1.2
		$BG.scroll_base_offset += Vector2(0, 1) * 260 * delta
	if GLOBAL.level == 4:
		$BGMusic.pitch_scale = 1.3
		$BG.scroll_base_offset += Vector2(0, 1) * 328 * delta
	if GLOBAL.level == 5:
		$BGMusic.pitch_scale = 1.5
		$BG.scroll_base_offset += Vector2(0, 1) * 396 * delta

func getMaxRand():
	if GLOBAL.level == 1:
		return 4
	if GLOBAL.level == 2:
		return 3
	if GLOBAL.level == 3:
		return 3
	if GLOBAL.level == 4:
		return 2
	if GLOBAL.level == 5:
		return 1

func _on_EnemySpawnTimer_timeout():
	$EnemySpawnPath/EnemySpawn.set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = $EnemySpawnPath/EnemySpawn.position
	$EnemySpawnTimer.wait_time = GLOBAL.random(1, getMaxRand())
	$EnemySpawnTimer.start()

func _on_HUD_game_over():
	$BGMusic.stop()
