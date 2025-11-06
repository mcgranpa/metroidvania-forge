class_name PlayerStateIdle extends PlayerState

func init() -> void:
	print("init: ", name)
	pass

func enter() -> void:
	print("enter: ", name)
	# play animation 
	pass

func exit() -> void:
	print("exit: ", name)
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	# add handle input code
	if (_event.is_action_pressed("jump")):
		return jump
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	player.direction.y = 0
	if player.direction.x != 0:
		return run
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	return next_state
