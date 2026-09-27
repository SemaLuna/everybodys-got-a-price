extends Node

# Holds references to all UI items
var uiItems = []
var is_game_paused = false
var is_game_started = false
var price_units_sold = 0

func _ready() -> void:
	uiItems = [$MainMenu, $PauseMenu, $HUD]
	reset_game_state()
	$PlanningPhase/Trash.connect("increase_score", on_increase_score)

func _process(delta: float) -> void:
	if (is_game_started):
		$HUD.update_score_banner(price_units_sold)

func on_increase_score():
	price_units_sold += 1
	$HUD.update_score_banner(price_units_sold)

func reset_game_state() -> void:
	# TODO Start background title music
	is_game_started = false
	is_game_paused = false
	price_units_sold = 0
	show_ui($MainMenu)
	var menu = $MainMenu
	menu.custom_function()

func start_game() -> void:
	is_game_started = true
	show_ui($HUD)
	
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

func unpause_game() -> void:
	# TODO make sure all other logic restarts (e.g. timers) when unpausing
	$PauseMenu.hide()

func quit_game() -> void:
	reset_game_state()
	
# Hides every other uiItem - use carefully, if you want to display multiple UI scenes at once
func show_ui(UiSceneToShow) -> void:
	for item in uiItems:
		if is_same(UiSceneToShow, item):
			item.show()
		else:
			item.hide()
	
