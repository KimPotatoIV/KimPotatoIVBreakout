extends Node

##################################################
@export var block_scene: PackedScene

##################################################
var block_width: float = 50
var block_height: float = 16
var start_x: float = 25
var start_y: float = 8
var rows: int = 10
var cols: int = 10

##################################################
func _ready() -> void:
	for row in range(rows):
		for col in range(cols): 
			var block_instance: Node2D = block_scene.instantiate()
			var position_x: float = start_x + col * block_width
			var position_y: float = start_y + row * block_height
			block_instance.global_position = Vector2(position_x, position_y)
			block_instance.item_type = randi_range(0, 8)
			
			var sprite_node = block_instance.get_node("Sprite2D") as Sprite2D
			if block_instance.item_type in [3, 4, 5]:
				sprite_node.texture = load("res://scenes/blocks/block_paddle.png")
			elif block_instance.item_type in [6, 7, 8]:
				sprite_node.texture = load("res://scenes/blocks/block_ball.png")
			
			add_child(block_instance)
