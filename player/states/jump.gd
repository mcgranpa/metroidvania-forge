class_name PlayerStateJump extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("jump")
	player.add_debug_indicator(Color.GREEN)
	player.velocity.y = - player.jump_velocity
	pass

func exit() -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	# add handle input code
	if _event.is_action_released("jump"):
		#player.velocity.y = 0
		# speed up player fall rate
		player.velocity.y *= 0.5
		return fall
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * (player.move_speed)
	return next_state
