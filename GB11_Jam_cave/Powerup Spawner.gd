extends Node2D

var powerUpScenes = [preload("res://Stop Time.tscn"),\
preload("res://Slow Down.tscn"),preload("res://Move Up.tscn"),\
preload("res://Deadly.tscn"),\
preload("res://Deadly.tscn")]  # Add your power-up scene resources here

var pos = []
export var spawnFrequency: float =  0.5 # Adjust the frequency (in seconds) between spawns

func _ready():
	randomize()  # Initialize random number generator
	$Timer.wait_time = spawnFrequency
	$Timer.start()
	pos = [$pos1.position, $pos2.position, $pos3.position,$pos4.position]
	#pos = [$pos1.global_position, $pos2.position, $pos3.position]
	
func _on_Timer_timeout():
	if powerUpScenes.size() > 0:
		var randomPowerUpScene = powerUpScenes[randi() % powerUpScenes.size()]
		var powerUpInstance = randomPowerUpScene.instance()
		# Set the position for the power-up instance
		var rand_pos = randf()
		if rand_pos < 0.2:
			powerUpInstance.position = pos[0]
		elif rand_pos < 0.3:
			powerUpInstance.position = pos[3]
		elif rand_pos < 0.7:
			powerUpInstance.position = pos[1]
		else:
			powerUpInstance.position = pos[2]
		#powerUpInstance.position = pos[randi() % pos.size()]
		add_child(powerUpInstance)

	$Timer.wait_time = spawnFrequency
	$Timer.start()
