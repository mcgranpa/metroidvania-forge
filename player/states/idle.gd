class_name PlayerStateIdle extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("idle")
	pass

func exit() -> void:
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	# add handle input code
	if (_event.is_action_pressed("jump")):
		return jump
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	# using 0.5 so player must push down more than just a little 
	# bit to enter crouch mode. this is needed more for the 
	# joystick since it returns a value between 0 and 1 or -1. 
	# the other keys return 0, 1, or -1. this can be changed
	# to adjust sensitivity
	if player.direction.y > sensitivity_check:
		return crouch
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	##### why is this check here?
	if player.is_on_floor() == false:
		return fall
	return next_state
