extends Node2D

const STOPTIME = 2
const SPEEDSLOW = 3 # 10
export var is_player_dead :bool = false
export var score : int = 0

var stop_time = false
var slow_down = false
var move_up = false
var score_th = 2

func _ready():
	$CanvasLayer/Label2.visible = false
	
func _process(delta):
	
	if is_player_dead:
		kill_player()
	if stop_time:
		stop_time = false
		$Timer.wait_time = STOPTIME
		$Timer.start()
		$Ceiling.is_stop = true
	if slow_down:
		slow_down = false
		$Ceiling.descent_speed = max(0,$Ceiling.descent_speed-SPEEDSLOW)
	if move_up:
		move_up = false
		$Ceiling.position.y = max($Ceiling.position.y-20, -72)
	
	if score > score_th:
		$CanvasLayer/Label.text = "Score: "+str(score) + " <<A>>"
		if Input.is_action_just_pressed("A"):
			$Special_timer.wait_time = 1.0
			$Special_timer.start()
			$CanvasLayer/Label2.visible = true
			$Ceiling.position.y -= 40
			score_th += 2
			#score -= score_th - 2
	else:
		$CanvasLayer/Label.text = "Score: "+ str(score)

func kill_player():
	var file_path = "user://score.txt"
	var file = File.new()
	# Open the file in write mode
	if file.open(file_path, File.WRITE) == OK:
		# Data to write to the file
		var data_to_save = str(score)
		# Write the data to the file
		file.store_line(str(data_to_save))
		# Close the file
		file.close()
	else:
		print("Failed to open the file for writing.")

	get_tree().change_scene("res://GameOver.tscn")


func _on_Timer_timeout():
	$Timer.wait_time = 0
	$Timer.stop()
	$Ceiling.is_stop = false


func _on_Special_timer_timeout():
	$Special_timer.wait_time = 0
	$Special_timer.stop()
	$CanvasLayer/Label2.visible = false
