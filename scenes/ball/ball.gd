extends RigidBody2D

##################################################
var velocity: Vector2 = Vector2()	# 공의 방향과 속도를 나타내는 벡터값

##################################################
func _ready() -> void:
	# 처음 시작 시 아래로 Ball이 움직이게 함
	velocity = Vector2(0, 1) * GameManager.get_ball_move_speed()
	linear_velocity = velocity	# 공의 현재 속도와 방향을 물리 엔진에 전달
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	await get_tree().process_frame	# Block 생성 시 까지 잠시 대기
	
	for block in get_tree().get_nodes_in_group("Block"):
		block.connect("block_hit_tb_signal", Callable(self, "_on_block_hit_tb_signal"))
		block.connect("block_hit_lr_signal", Callable(self, "_on_block_hit_lr_signal"))

##################################################
func _process(delta: float) -> void:
	# 공 속도 GameManager에 따라 움직이도록 설정
	if velocity.length() != GameManager.get_ball_move_speed():
		velocity = velocity.normalized() * GameManager.get_ball_move_speed()
		linear_velocity = velocity
		
	# Y 좌표가 360보다 낮아지면 게임 오버
	if global_position.y > 360:
		GameManager.game_over = true

##################################################
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Paddle"):
		var ball_position: Vector2 = self.global_position
		var paddle_position: Vector2 = body.global_position
		var offset: float = ball_position.x - paddle_position.x
		var paddle_shape: RectangleShape2D = \
			body.get_node("CollisionShape2D").shape as RectangleShape2D
		var paddle_width: float = paddle_shape.extents.x
		var normalized_offset: float = offset / paddle_width
		var reflection_vector: Vector2 = Vector2(normalized_offset, -1).normalized()
		velocity = reflection_vector * velocity.length()
		# Ball이 Paddle의 좌우 어디에 충돌하는지에 따라 튕겨지는 각도를 다르게 하기 위함
	elif body.is_in_group("LeftWall") or body.is_in_group("RightWall"):
		velocity = Vector2(-velocity.x, velocity.y)
		# 좌우 벽에 충돌 시 X 좌표만 반대로
	elif body.is_in_group("TopWall"):
		velocity = Vector2(velocity.x, -velocity.y)
		# 상 벽에 충돌 시 Y 좌표만 반대로

	linear_velocity = velocity
	$AudioStreamPlayer2DPaddle.play()	# Paddle 충돌 소리 재생

##################################################
func _on_block_hit_tb_signal()-> void:	# 상하 충돌 시 Y 좌표만 반대로
	velocity = Vector2(velocity.x, -velocity.y)
	linear_velocity = velocity
	$AudioStreamPlayer2DBlock.play()	# Block 충돌 소리 재생

##################################################
func _on_block_hit_lr_signal()-> void:	# 좌우 충돌 시 X 좌표만 반대로
	velocity = Vector2(-velocity.x, velocity.y)
	linear_velocity = velocity
	$AudioStreamPlayer2DBlock.play()	# Block 충돌 소리 재생
