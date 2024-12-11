extends GPUParticles2D

##################################################
func _process(delta: float) -> void:
	scatter_particles()
	update_particle_color()

##################################################
# Paddle 파티클이 패들 좌우 사이에서 임의로 흩뿌려지도록 하기 위함
func scatter_particles() -> void:
	var paddle_width: float = $"../Sprite2D".texture.get_size().x
	var rand_offset: float = randf_range(-paddle_width / 2, paddle_width / 2)
	self.global_position.x = $"..".position.x + rand_offset

##################################################
func update_particle_color() -> void:
	var paddle_speed = GameManager.get_paddle_move_speed()
	var min_speed = GameManager.get_paddle_min_move_speed()
	var max_speed = GameManager.get_paddle_max_move_speed()
	
	var normalized_speed = (paddle_speed - min_speed) / (max_speed - min_speed)
	# Paddle 속도를 최대 및 최저 속도에 비례하여 정규화
	
	var particle_color = Color(	# Paddle 정규화 속도에 따른 색상 보간
		lerp(1.0, 0.0, normalized_speed),
		lerp(0.0, 1.0, normalized_speed),
		0.0, 1.0
		)
		
	process_material.set("color", particle_color)	# Paddle 파티클 색 표현 설정
