extends Node2D

var score := 0

func _ready():
	# Define the file path within the game's directory
	var file_path = "user://score.txt"

	# Create a File object
	var file = File.new()

	if file.open(file_path, File.READ) == OK:
		# Read the contents of the file as a string
		var file_contents = file.get_line()
		
		# Close the file
		file.close()
		
		# Convert the string back to an integer
		var saved_integer = int(file_contents)
		score = saved_integer
		
		# Do something with the integer (e.g., print it)
		print("Saved integer:", saved_integer)
	else:
		print("Failed to open the file for reading.")
		
	$score.text = "Score: " + str(score)
	
func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
	


