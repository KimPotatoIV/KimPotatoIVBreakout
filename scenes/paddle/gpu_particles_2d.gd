extends GPUParticles2D

##################################################
func _process(delta: float) -> void:
	var paddle_width: float = $"../Sprite2D".texture.get_size().x
	var rand_offset: float = randf_range(-paddle_width / 2, paddle_width / 2)
	self.global_position.x = $"..".position.x + rand_offset
	
	update_particle_color()

##################################################
func update_particle_color() -> void:
	var normalized_speed = (
		GameManager.get_paddle_move_speed() -
		GameManager.get_paddle_min_move_speed()
		) / (
		GameManager.get_paddle_max_move_speed() -
		GameManager.get_paddle_min_move_speed()
		)
	var particle_color = Color(
		lerp(1.0, 0.0, normalized_speed),
		lerp(0.0, 1.0, normalized_speed),
		0.0, 1.0
		)
		
	process_material.set("color", particle_color)
