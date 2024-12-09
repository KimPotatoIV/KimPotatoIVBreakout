extends CharacterBody2D

##################################################
var position_y: float

##################################################
func _ready() -> void:
	position_y = position.y

##################################################
func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * GameManager.paddle_move_speed
	move_and_slide()
	
	position.y = position_y
