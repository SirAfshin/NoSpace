extends StaticBody2D

var initial_position  # Set this to the initial position of the ceiling
export var descent_speed: float = 10 #50  # Adjust the speed at which the ceiling descends
export var acceleration :float = 1.3 #10
export var max_descent_speed : int = 100
var threshold = 100  # Threshold at which the descent speed stops increasing
var is_stop = false

func _ready():
	initial_position = position

func _process(delta):

	# Increase the descent speed gradually until it reaches the threshold
	if descent_speed < max_descent_speed and !is_stop :
		descent_speed += acceleration * delta
		#print("in speed")
	if !is_stop:
		position.y  += descent_speed * delta
		
	if position.y >= 40:
		get_parent().is_player_dead = true
		#print("ceiling colapsed and playe died")
