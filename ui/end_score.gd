extends CanvasLayer

func update_final_score(score) -> void:
	$FinalScoreValue.text = "[b]" + str(score) + "[/b]"