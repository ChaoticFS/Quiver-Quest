extends CharacterBody2D

const SPEED = 250.0
const MAX_SPEED = 450
const JUMP_VELOCITY = -350.0
const GRAVITY_MODIFIER = 1.25
const ACCELERATION = 50
const FRICTION = 40

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var arrow : PackedScene = preload("res://Global/Player/Arrow/Arrow.tscn")

func _physics_process(delta):
	var motion = Vector2(velocity.x,velocity.y)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * GRAVITY_MODIFIER
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = move_toward(motion.x, direction * MAX_SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(motion.x, 0, FRICTION)
	
	motion = motion.normalized()
	motion = move_and_slide()

	if Input.is_action_just_pressed("ui_fire"):
		launch_arrow()

	# Should probably move these global actions to a root class 
	# of some kind, kind of awkward to have on the player
	if Input.is_action_just_pressed("ui_reload"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("ui_exit"):
		get_tree().change_scene_to_file("res://Scene/Main Menu/main_menu.tscn")

func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://Scene/Main Menu/main_menu.tscn")

func launch_arrow():
	var arrow_instance = arrow.instantiate()
	var arrow_vector = Vector2()
	arrow_instance.launch(arrow_vector, global_position)
	get_tree().get_root().call_deferred("add_child",arrow_instance)

