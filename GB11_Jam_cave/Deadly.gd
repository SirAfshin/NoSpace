extends Node2D

export var speed :float= 100
var direction = Vector2(-1, 0)

func _physics_process(delta):
	var velocity = direction.normalized() * speed
	position  += velocity * delta
	rotation_degrees += 150 *delta
	
	if global_position.x <= -1:
		queue_free()
		
	

func _on_deadly_body_entered(body):
	if body.name == "Player": 
		body.get_parent().is_player_dead = true
		queue_free() # Remove the power-up
