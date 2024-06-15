extends Node
@onready var score_label = $ScoreLabel

var score = 0

func add_score():
	score += 1
	print(score)
	score_label.text = "Score: " + str(score)

