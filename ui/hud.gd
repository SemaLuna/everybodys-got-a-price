extends CanvasLayer

signal pause_game
signal build_mode

@export var conveyor_scene : PackedScene
@onready var buttons = [$ConveyorButton, $TrashButton]
var is_building = false

func _on_pause_button_pressed() -> void:
	pause_game.emit()

func update_score_banner(score) -> void:
	$ScoreBanner/PriceSoldValue.text = "[i]" + str(score) + "[/i]"

func _on_trash_button_toggled(toggled_on: bool) -> void:
	for button in buttons:
		(button as BaseButton).set_toggle_mode(false)
	$TrashButton.set_toggle_mode(true)
	build_mode.emit(toggled_on, null)

func _on_conveyor_button_pressed() -> void:
	update_build_state($ConveyorButton)
	var scene = conveyor_scene if is_building else null
	build_mode.emit(is_building, scene)

func _on_trash_button_pressed() -> void:
	update_build_state($TrashButton)
	build_mode.emit(is_building, null)

func update_build_state(button: BaseButton) -> void:
	var currently_active_button = button.is_toggle_mode()
	if (currently_active_button):
		is_building = false
	else: if(not is_building): 
		is_building = !is_building
		
	# Update other button states
	for possible_button in buttons:
		if (possible_button != button):
			possible_button.set_toggle_mode(false)
			possible_button.set_pressed(false)
			
	# Update current button state
	button.set_toggle_mode(is_building)
	button.set_pressed(is_building)
