extends CharacterBody2D

@export var MASS = 20

var VELOCITY_MODIFIER = 3
var GRAVITY = 100.25
var collided = false
var GRAVITY_VEC = Vector2.DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not collided:
		velocity += GRAVITY_VEC * GRAVITY * MASS * delta
		rotation = velocity.angle()
		var collision = move_and_collide(velocity * delta)
		if collision != null:
			collided = true

func launch(initial_velocity : Vector2, fire_position):
	velocity = initial_velocity * VELOCITY_MODIFIER
	rotation = velocity.angle()
	position = fire_position
