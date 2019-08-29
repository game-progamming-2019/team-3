extends CanvasLayer

onready var score_progress = $MarginContainer/VBoxContainer/NinePatchRect/HBoxLeft/ScoreProgress
onready var score_max_label = $MarginContainer/VBoxContainer/NinePatchRect/HBoxRight/ScoreMax
onready var score_value_label = $MarginContainer/VBoxContainer/NinePatchRect/HBoxRight/ScoreValue
onready var tween_score = $TweenScore

var animated_score = 0

func _ready():
	pass

func _process(delta):
	if tween_score.is_active():
		score_progress.value = animated_score
		score_value_label.text = str(int(animated_score))

func set_max_score(score_max):
	score_progress.max_value = score_max
	score_max_label.text = str(score_max)

func set_score(score):
	tween_score.interpolate_property(self, "animated_score", animated_score, score, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	if not tween_score.is_active():
		tween_score.start()