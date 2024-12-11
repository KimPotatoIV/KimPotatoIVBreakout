extends CharacterBody2D

##################################################
var position_y: float	# Paddle Y 좌표 고정을 위한 변수

##################################################
func _ready() -> void:
	position_y = position.y	# Paddle Y 좌표 고정을 위해 초기값 설정

##################################################
func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * GameManager.paddle_move_speed
	move_and_slide()	# 좌우 이동
	
	position.y = position_y	# Paddle Y 좌표 고정
