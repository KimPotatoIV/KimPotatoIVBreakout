extends CanvasLayer

@onready var score_label = $MarginContainer/ScoreLabel

##################################################
func _ready() -> void:
	pass

##################################################
func _process(delta: float) -> void:
	score_label.text = "SCORE\n" + str(GameManager.get_game_score()).pad_zeros(5)
