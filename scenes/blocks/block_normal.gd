extends Area2D

##################################################
signal block_hit_tb_signal
signal block_hit_lr_signal

##################################################
var item_type: int = 0

##################################################
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		var ball_position: Vector2 = body.global_position
		var block_position: Vector2 = self.global_position
		var offset: float = abs(ball_position.x - block_position.x)
		
		var block_shape: RectangleShape2D = \
			self.get_node("CollisionShape2D").shape as RectangleShape2D
		var block_width: float = block_shape.extents.x
		
		if offset >= block_width:
			emit_signal("block_hit_lr_signal")
		else:
			emit_signal("block_hit_tb_signal")
		
		apply_item()
		GameManager.set_game_score(GameManager.get_game_score() + 100)
		queue_free()

##################################################
func apply_item() -> void:
	match item_type:
		3, 4:
			GameManager.set_paddle_move_speed(GameManager.get_paddle_move_speed() * 1.5)
		5:
			GameManager.set_paddle_move_speed(GameManager.get_paddle_move_speed() * 0.9)
		6, 7:
			GameManager.set_ball_move_speed(GameManager.get_ball_move_speed() * 1.25)
		8:
			GameManager.set_ball_move_speed(GameManager.get_ball_move_speed() * 0.9)
