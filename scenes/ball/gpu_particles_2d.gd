extends GPUParticles2D

##################################################
func _process(delta: float) -> void:
	update_particle_color()

##################################################
func update_particle_color() -> void:
	var ball_speed = GameManager.get_ball_move_speed()
	var min_speed = GameManager.get_ball_min_move_speed()
	var max_speed = GameManager.get_ball_max_move_speed()
	
	var normalized_speed = (ball_speed - min_speed) / (max_speed - min_speed)
	
	var particle_color = Color(
		lerp(1.0, 0.0, normalized_speed),
		lerp(0.0, 1.0, normalized_speed),
		0.0, 0.25
		)
		
	process_material.set("color", particle_color)
