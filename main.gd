extends Node

# Holds references to all UI items
var uiItems = []
var is_game_paused = false
var is_game_started = false

func _ready() -> void:
	uiItems = [$MainMenu, $PauseMenu, $HUD]
	reset_game_state()

func _process(delta: float) -> void:
	pass

func reset_game_state() -> void:
	# TODO Start background title music
	is_game_started = false
	is_game_paused = false
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
	show_ui($PauseMenu)

func unpause_game() -> void:
	# TODO make sure all other logic restarts (e.g. timers) when unpausing
	show_ui($HUD)

func quit_game() -> void:
	reset_game_state()
	
# Hides every other uiItem - use carefully, if you want to display multiple UI scenes at once
func show_ui(UiSceneToShow) -> void:
	print(UiSceneToShow)
	for item in uiItems:
		if is_same(UiSceneToShow, item):
			item.show()
		else:
			item.hide()
	
