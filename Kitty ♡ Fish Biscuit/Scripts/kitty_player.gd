extends CharacterBody2D

@export var speed = 9.0
@export var jump_power = 9.0

var speed_multiplier = 30.0
var jump_multiplier = -50.0
var direction = 0

#const SPEED = 300
#const JUMP_VELOCITY = -400


func _physics_process(delta: float) -> void:
	# Add thde gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power*jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
	handle_animation()

func handle_animation():
	if is_on_floor():
		if velocity:
			$AnimatedSprite2D.play("walking")
			if velocity.x != 0:
				$AnimatedSprite2D.flip_h = velocity.x < 0
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("jumping")

	
	
