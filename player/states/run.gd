class_name PlayerStateRun extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	# play animatoin
	pass

func exit() -> void:
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	if (_event.is_action_pressed("jump")):
		return jump

	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return next_state
