extends Node

onready var score : int
onready var level : int
var status = "menu"
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func random(min_number, max_number):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)
	return random


func _process(delta):
	if score >= 100:
		level = 2
	if score >= 200:
		level = 3
	if score >= 300:
		level = 4
	if score >= 400:
		level = 5
