extends GPUParticles2D

##################################################
func _process(delta: float) -> void:
	update_particle_color()	# Ball 궤적 잔상 색 표현 함수

##################################################
func update_particle_color() -> void:
	var ball_speed = GameManager.get_ball_move_speed()
	var min_speed = GameManager.get_ball_min_move_speed()
	var max_speed = GameManager.get_ball_max_move_speed()
	
	var normalized_speed = (ball_speed - min_speed) / (max_speed - min_speed)
	# Ball 속도를 최 및 최저 속도에 비례하여 정규화
	
	var particle_color = Color(	# Ball 정규화 속도에 따른 색상 보간
		lerp(1.0, 0.0, normalized_speed),
		lerp(0.0, 1.0, normalized_speed),
		0.0, 0.25
		)
		
	process_material.set("color", particle_color)	# 궤적 잔상 색 표현 설정
