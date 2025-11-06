class_name PlayerStateFall extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	# play animatoin
	pass

func exit() -> void:
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	# add handle input code
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	return next_state
