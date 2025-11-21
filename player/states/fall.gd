class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.15
@export var jump_buffer_time : float = 0.15
@export var fall_gravity_multiplier : float = 1.165

var coyote_timer : float = 0.0
var buffer_timer : float = 0.0

func init() -> void:
	pass

func enter() -> void:
	# start the animation but pause it
	# frames will be adjusted in process function
	# jump animation includes fall animaiton
	player.animation_player.play("jump")
	player.animation_player.pause()
	#print("fall start velocity: ", player.velocity.y)
	player.gravity_multiplier = fall_gravity_multiplier

	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass

func exit() -> void:
	#print("fall end velocity: ", player.velocity.y)
	player.gravity_multiplier = player.default_gravity_multiplier
	buffer_timer = 0
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	# add handle input code
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		buffer_timer = jump_buffer_time
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	set_jump_frame()
	coyote_timer -= _delta
	buffer_timer -= _delta
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator(Color.RED)
		# for jump buffer to work, jump buttone must 
		# still be held down to avoid bug that prevents
		# variable jump from working if jump button 
		# released before enter the jump state this is one fix
		# see jump state for another fix 
		## if buffer_timer > 0.0 and Input.is_action_pressed("jump"):
		if buffer_timer > 0.0:
			return jump
		return idle
	player.velocity.x = player.direction.x * player.move_speed

	return next_state

func set_jump_frame() -> void:
	# set animation frame based on fall velocity 
	# see jump animation for frames. 
	var frame : float = remap(player.velocity.y, 0.0, player.max_fall_velocity
		, 0.5, 1.0)
	#print("fall velocity: ", player.velocity.y, " frame: ", frame)
	# play the frame 
	player.animation_player.seek(frame, true)
	pass
