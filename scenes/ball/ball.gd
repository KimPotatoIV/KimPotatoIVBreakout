extends RigidBody2D

##################################################
var velocity: Vector2 = Vector2()

##################################################
func _ready() -> void:
	velocity = Vector2(0, 1) * GameManager.get_ball_move_speed()
	linear_velocity = velocity
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	await get_tree().process_frame
	
	for block in get_tree().get_nodes_in_group("Block"):
		block.connect("block_hit_tb_signal", Callable(self, "_on_block_hit_tb_signal"))
		block.connect("block_hit_lr_signal", Callable(self, "_on_block_hit_lr_signal"))

##################################################
func _process(delta: float) -> void:
	if velocity.length() != GameManager.get_ball_move_speed():
		velocity = velocity.normalized() * GameManager.get_ball_move_speed()
		linear_velocity = velocity
		
	if global_position.y > 360:
		GameManager.game_over = true

##################################################
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Paddle"):
		var ball_position: Vector2 = self.global_position
		var paddle_position: Vector2 = body.global_position
		var offset: float = ball_position.x - paddle_position.x
		var paddle_shape: RectangleShape2D = body.get_node("CollisionShape2D").shape as RectangleShape2D
		var paddle_width: float = paddle_shape.extents.x
		var normalized_offset: float = offset / paddle_width
		var reflection_vector: Vector2 = Vector2(normalized_offset, -1).normalized()
		velocity = reflection_vector * velocity.length()
	elif body.is_in_group("LeftWall") or body.is_in_group("RightWall"):
		velocity = Vector2(-velocity.x, velocity.y)
	elif body.is_in_group("TopWall"):
		velocity = Vector2(velocity.x, -velocity.y)

	linear_velocity = velocity
	$AudioStreamPlayer2DPaddle.play()

##################################################
func _on_block_hit_tb_signal()-> void:
	velocity = Vector2(velocity.x, -velocity.y)
	linear_velocity = velocity
	$AudioStreamPlayer2DBlock.play()

##################################################
func _on_block_hit_lr_signal()-> void:
	velocity = Vector2(-velocity.x, velocity.y)
	linear_velocity = velocity
	$AudioStreamPlayer2DBlock.play()
