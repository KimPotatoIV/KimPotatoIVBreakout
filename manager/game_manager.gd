extends Node

##################################################
var paddle_move_speed: float = 200
var paddle_min_move_speed: float = 100
var paddle_max_move_speed: float = 400

var ball_move_speed: float = 100
var ball_min_move_speed: float = 100
var ball_max_move_speed: float = 300

var game_score = 0

##################################################
func get_paddle_move_speed() -> float:
	return paddle_move_speed

##################################################
func get_paddle_min_move_speed() -> float:
	return paddle_min_move_speed

##################################################
func get_paddle_max_move_speed() -> float:
	return paddle_max_move_speed

##################################################
func set_paddle_move_speed(value: float) -> void:
	paddle_move_speed = value
	
	if value <= paddle_min_move_speed:
		paddle_move_speed = paddle_min_move_speed
	elif value >= paddle_max_move_speed:
		paddle_move_speed = paddle_max_move_speed

##################################################
func get_ball_move_speed() -> float:
	return ball_move_speed

##################################################
func get_ball_min_move_speed() -> float:
	return ball_min_move_speed

##################################################
func get_ball_max_move_speed() -> float:
	return ball_max_move_speed

##################################################
func set_ball_move_speed(value: float) -> void:
	ball_move_speed = value
	
	if value <= ball_min_move_speed:
		ball_move_speed = ball_min_move_speed
	elif value >= ball_max_move_speed:
		ball_move_speed = ball_max_move_speed

##################################################
func get_game_score() -> int:
	return game_score

##################################################
func set_game_score(value: int):
	game_score = value
