@icon( "res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState = null
var sensitivity_check : float = 0.5

#region /// state reference
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %jump
@onready var fall: PlayerStateFall = %fall
@onready var crouch: PlayerStateCrouch = %Crouch
#endregion

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

# runs when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	return next_state

# runs each process tick for this state
func process(_delta: float) -> PlayerState:
	return next_state

# runs each physics process tick for this state
func physics_process(_delta: float) -> PlayerState:
	return next_state
