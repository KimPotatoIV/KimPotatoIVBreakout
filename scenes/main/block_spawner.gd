extends Node

##################################################
@export var block_scene: PackedScene

##################################################
var block_width: float = 50	#Block 가로 길이
var block_height: float = 16	# Block 세로 길이
var start_x: float = 25	# Block 좌표 시작점 (이미지 중앙 좌표 기준)
var start_y: float = 8	# Block 좌표 시작점 (이미지 중앙 좌표 기준)
var rows: int = 10	# Block 행 개수
var cols: int = 10	# Block 열 개수

var paddle_block_texture: Texture2D	# Paddle 효과를 변경시키는 Block
var ball_block_texture: Texture2D	# Ball 효과를 변경시키는 Block

##################################################
func _ready() -> void:
	# 각각 이미지 로드
	paddle_block_texture = load("res://scenes/blocks/block_paddle.png")
	ball_block_texture = load("res://scenes/blocks/block_ball.png")
	
	for row in range(rows):	# 각 행마다
		for col in range(cols):	# 열 개 열을 반복하여 넣음
			var block_instance: Node2D = block_scene.instantiate()	# 인스턴스화 시켜서
			var position_x: float = start_x + col * block_width
			var position_y: float = start_y + row * block_height	# 좌표를 설정
			block_instance.global_position = Vector2(position_x, position_y)
			block_instance.item_type = randi_range(0, 8)	# 아이템 종류 지정
			
			var sprite_node: Sprite2D = block_instance.get_node("Sprite2D") as Sprite2D
			
			match block_instance.item_type:	# 아이템 종류에 따라 텍스쳐를 다르게 설정
				3, 4, 5:
					sprite_node.texture = paddle_block_texture
				6, 7, 8:
					sprite_node.texture = ball_block_texture
					
			add_child(block_instance)
