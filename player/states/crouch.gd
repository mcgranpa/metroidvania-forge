class_name PlayerStateCrouch extends PlayerState

# use 10 if it's used to slow down and stop when crouching 
# use 0.25 if slowing move speed when running while crouched 
@export var decelaration_rate : float = 10

func init() -> void:
	pass

func enter() -> void:
	# play animation 
	player.collision_crouch.disabled = false
	player.collision_stand.disabled = true
	player.player_sprite.scale.y = 0.625
	player.player_sprite.position.y = -15.0
	pass

func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	player.player_sprite.scale.y = 1.0
	player.player_sprite.position.y = -24.0
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	if (_event.is_action_pressed("jump")):
		if player.one_way_platform_raycast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	# this is the 0.5 for sensitivity uisng the joystick
	if player.direction.y <= sensitivity_check:
		return idle

	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	#player.velocity.x = 0
	# don't stop instantly; slow down before 
	# crouching this will never reach 0 but 
	# shouldn't be noticable. 
	# the slow down is over time so _delta is needed
	player.velocity.x = player.velocity.x * (decelaration_rate * _delta)
	# you can move, just much slower. handling "run" here rather 
	# than in run state.  
	#player.velocity.x = player.direction.x * player.move_speed * decelaration_rate 
	if player.is_on_floor() == false:
		return fall
	return next_state
