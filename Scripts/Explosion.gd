extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	$SoundExplosion.play()


func _on_SoundExplosion_finished():
	queue_free()
