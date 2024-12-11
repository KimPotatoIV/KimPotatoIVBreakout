extends Area2D

##################################################
signal block_hit_tb_signal	# Block의 상하에 충돌 시 signal 발생
signal block_hit_lr_signal	# Block의 좌우에 충돌 시 signal 발생

##################################################
var item_type: int = 0	# 아이템 종류
'''
0, 1, 2:	보통 Block
3, 4: 		Paddle 속도 증가
5: 			Paddle 속도 감수
6, 7:		Ball 속도 증가
8:			Ball 속도 감소
'''

##################################################
func _ready() -> void:
	# body_entered 신호를 _on_body_entered 함수와 연결
	connect("body_entered", Callable(self, "_on_body_entered"))

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):	# Ball이 충돌했을 때
		var ball_position: Vector2 = body.global_position
		var block_position: Vector2 = self.global_position
		var offset: float = abs(ball_position.x - block_position.x)
		# offset은 Block에 Ball이 어디에 충돌했는지 측정을 위함
		
		var block_shape: RectangleShape2D = \
			self.get_node("CollisionShape2D").shape as RectangleShape2D
		var block_width: float = block_shape.extents.x
		
		# offset에 따른 충돌 지점에 따라 다른 신호를 발생
		if offset >= block_width:
			emit_signal("block_hit_lr_signal")
		else:
			emit_signal("block_hit_tb_signal")
		
		apply_item()	# 아이템 효과 적용
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
