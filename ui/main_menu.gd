extends CanvasLayer

@onready var animatedIntro = $AnimatedSprite2D
@onready var startButton = $StartGame
@onready var timer = $Timer
signal start_game

func _on_start_game_pressed() -> void:
	start_game.emit()

func _on_timer_timeout() -> void:
	startButton.visible = true
	startButton.disabled = false
	
func reset_main_menu():
	startButton.visible = false
	startButton.disabled = true
	animatedIntro.play("default")
	timer.start()
