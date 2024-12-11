extends CanvasLayer

##################################################
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $GameOverLabel

##################################################
func _ready() -> void:
	game_over_label.visible = false	# 게임 오버 라벨 숨김

##################################################
func _process(delta: float) -> void:
	score_label.text = "SCORE\n" + str(GameManager.get_game_score()).pad_zeros(5)
	# 점수 실시간 적용
	
	if GameManager.game_over == true:	# 게임 오버 시 게임 오버 라벨 보이게 함
		game_over_label.visible = true
