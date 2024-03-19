extends KinematicBody2D

export var MOVE_SPEED : int = 75  # Adjust the movement speed as needed
export var GRAVITY : int = 800  # Adjust the gravity as needed
export var JUMP_FORCE : int = -250  # Adjust the jump force as needed

var velocity = Vector2()
var is_jumping = false

func _ready():
	$AnimatedSprite.play("Stand")
	
func _physics_process(delta):
	# Character Movement
	velocity.x = 0  # Reset horizontal velocity
	
	if Input.is_action_pressed("left"):
		velocity.x -= MOVE_SPEED
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x += MOVE_SPEED
		$AnimatedSprite.flip_h = false

	# Apply Gravity
	velocity.y += GRAVITY * delta

	# Jumping
	if is_on_floor():
		is_jumping = false
		if Input.is_action_pressed("up"):
			velocity.y = JUMP_FORCE
			is_jumping = true

	# Move the character
	velocity = move_and_slide(velocity, Vector2.UP)

	# Update animation or other character-specific logic here
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite.play("Run")
	else :
		$AnimatedSprite.play("Stand")
		
	

