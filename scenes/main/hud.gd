extends CanvasLayer

##################################################
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $GameOverLabel

##################################################
func _ready() -> void:
	game_over_label.visible = false

##################################################
func _process(delta: float) -> void:
	score_label.text = "SCORE\n" + str(GameManager.get_game_score()).pad_zeros(5)
	
	if GameManager.game_over == true:
		game_over_label.visible = true
