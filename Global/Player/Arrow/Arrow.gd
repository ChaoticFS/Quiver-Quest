extends RigidBody2D

@export var arrow_mass = 0.80

var gravity = 1.25
var launched = false
var velocity = Vector2(0,0)
var gravity_vec = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launched:
		velocity += gravity_vec * gravity * arrow_mass * delta
		position += velocity * delta
		rotation += velocity.angle()

func launch(initial_velocity : Vector2, fire_position):
	launched = true
	velocity = initial_velocity
	position = fire_position
