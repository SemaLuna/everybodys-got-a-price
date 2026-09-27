extends Node

# Holds references to all UI items
var uiItems = []
var is_game_paused = false
var is_game_started = false
var price_units_sold = 0

# Signals for music
signal title
signal intro

func _ready() -> void:
	uiItems = [$MainMenu, $PauseMenu, $HUD]
	reset_game_state()
	$PlanningPhase.trashInstance.connect("item_delivered", on_increase_score)

func _process(delta: float) -> void:
	if (is_game_started):
		$HUD.update_score_banner(price_units_sold)

func on_increase_score():
	price_units_sold += 1
	$HUD.update_score_banner(price_units_sold)

func reset_game_state() -> void:
	emit_signal("title")
	is_game_started = false
	is_game_paused = false
	price_units_sold = 0
	show_ui($MainMenu)
	
	$PlanningPhase.hide()
	var menu = $MainMenu
	menu.reset_main_menu()

func start_game() -> void:
	emit_signal("intro")
	is_game_started = true
	show_ui($HUD)
	$PlanningPhase.show()
	
func handle_pause() -> void:
	if (!is_game_started): pass
	
	is_game_paused = !is_game_paused
	if (is_game_paused):
		pause_game()
	else:
		unpause_game()
	
func pause_game() -> void:
	# TODO make sure all the other logic pauses (e.g. timers)
	$PauseMenu.show()
	get_tree().call_group("Animations", "pause")

func unpause_game() -> void:
	# TODO make sure all other logic restarts (e.g. timers) when unpausing
	$PauseMenu.hide()
	get_tree().call_group("Animations", "play")

func quit_game() -> void:
	reset_game_state()
	
# Hides every other uiItem - use carefully, if you want to display multiple UI scenes at once
func show_ui(UiSceneToShow) -> void:
	for item in uiItems:
		if is_same(UiSceneToShow, item):
			item.show()
		else:
			item.hide()
	
