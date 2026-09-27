extends CanvasLayer

@onready var animatedIntro = $AnimatedSprite2D
@onready var startButton = $StartGame
signal start_game

func _on_start_game_pressed() -> void:
	start_game.emit()
	
func reset_main_menu():
	startButton.visible = false
	startButton.disabled = true
	animatedIntro.play("default")

func _on_animated_sprite_2d_animation_finished() -> void:
	startButton.visible = true
	startButton.disabled = false
