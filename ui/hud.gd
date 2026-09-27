extends CanvasLayer

signal pause_game
signal build_mode
signal rotation_updated

@export var conveyor_scene : PackedScene
@export var stretch_machine_scene : PackedScene
@export var stretch_machine_red_scene : PackedScene
@export var stretch_machine_yellow_scene : PackedScene
@onready var buttons = [$ConveyorButton, $TrashButton, $StretchMachineButton, $StretchMachineRedButton, $StretchMachineYellowButton, $ConveyorTurnRightButton, $ConveyorTurnLeftButton, $Rotate90Button]
var is_building = false
var build_rotation = 0

func update_countdown_display(timeleft):
	$Countdown.text = str(int(round(timeleft)))

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
	build_mode.emit(is_building, scene, null)
	
func _on_conveyor_turn_right_button_pressed() -> void:
	update_build_state($ConveyorTurnRightButton)
	var scene = conveyor_scene if is_building else null
	var turn = "turn-right"
	build_mode.emit(is_building, scene, turn)
	
func _on_conveyor_turn_left_button_pressed() -> void:
	update_build_state($ConveyorTurnLeftButton)
	var scene = conveyor_scene if is_building else null
	var turn = "turn-left"
	build_mode.emit(is_building, scene, turn)

func _on_trash_button_pressed() -> void:
	update_build_state($TrashButton)
	build_mode.emit(is_building, null, null)
	
func _on_stretch_machine_button_pressed() -> void:
	update_build_state($StretchMachineButton)
	var scene = stretch_machine_scene if is_building else null
	build_mode.emit(is_building, scene, null)
	
func _on_stretch_machine_red_button_pressed() -> void:
	update_build_state($StretchMachineRedButton)
	var scene = stretch_machine_red_scene if is_building else null
	build_mode.emit(is_building, scene, null)
	
func _on_stretch_machine_yellow_button_pressed() -> void:
	update_build_state($StretchMachineYellowButton)
	var scene = stretch_machine_yellow_scene if is_building else null
	build_mode.emit(is_building, scene, null)

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

func _on_rotate_90_button_pressed() -> void:
	build_rotation += PI/2
	rotation_updated.emit(build_rotation)
	for button in buttons:
		if (button != $Rotate90Button) && (button != $TrashButton):
			button.rotation = build_rotation
