class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://cn3pv6slcb2b2")

#region /// export variables
@export var move_speed : float = 150.0 
@export var jump_velocity : float = 450.0 
@export var use_debug_indicator : bool = true
#endregion

#region /// onready variables
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_raycast: RayCast2D = $OneWayPlatformRaycast
#endregion

#region /// State Machine Variables
var states : Array[PlayerState]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// standard variables
var gravity:float = 980
var gravity_multiplier : float = 1.0
var default_gravity_multiplier : float = 1.0

var direction: Vector2 = Vector2.ZERO
var prev_direction: Vector2
#endregion


func _ready() -> void:
	initialize_states()
	gravity_multiplier = default_gravity_multiplier
	#gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass
	
func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass
	
func _physics_process(_delta: float) -> void:
	velocity.y += (gravity * gravity_multiplier) * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	pass
	
func initialize_states() -> void:
	states = []
	
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
	
	# may want to add some error handling
	if states.size() == 0:
		return
		
	for state in states:
		state.player = self
		state.init()
	
	current_state.enter()
	$Label.text = current_state.name
	pass
	
func change_state ( new_state:PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	# keeps the list of states from growing too large
	states.resize(3)
	$Label.text = current_state.name
	pass
	
func update_direction() -> void:
	prev_direction = direction
	var x_axis = Input.get_axis("left" , "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	pass
	
func add_debug_indicator(color : Color = Color.RED) -> void:
	if use_debug_indicator == false:
		return
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d.queue_free()
	pass
	
	
