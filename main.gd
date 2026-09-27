extends Node

# Holds references to all UI items
var uiItems = []
var is_game_paused = false
var is_game_started = false
var price_units_sold = 0


func _ready() -> void:
	uiItems = [$MainMenu, $PauseMenu, $HUD]
	reset_game_state()
	$PlanningPhase.trashInstance.connect("item_delivered", on_increase_score)

func _process(delta: float) -> void:
	if (is_game_started):
		$HUD.update_score_banner(price_units_sold)
		$HUD.update_countdown_display($Countdown.time_left)
		$EndScore.update_final_score(price_units_sold)

func on_increase_score():
	price_units_sold += 1
	$HUD.update_score_banner(price_units_sold)

func _on_countdown_timeout() -> void:
	quit_game()

func reset_game_state() -> void:
	# TODO Start background title music
	is_game_started = false
	is_game_paused = false
	price_units_sold = 0
	show_ui($MainMenu)
	
	$PlanningPhase.hide()
	var menu = $MainMenu
	menu.reset_main_menu()

func start_game() -> void:
	is_game_started = true
	show_ui($HUD)
	$PlanningPhase.show()
	$Countdown.set_paused(false)
	$Countdown.start()
	
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
	$Countdown.set_paused(true)

func unpause_game() -> void:
	# TODO make sure all other logic restarts (e.g. timers) when unpausing
	$PauseMenu.hide()
	get_tree().call_group("Animations", "play")
	$Countdown.set_paused(false)

func quit_game() -> void:
	$EndScore.show()
	await get_tree().create_timer(5.0).timeout
	$EndScore.hide()
	reset_game_state()
	
# Hides every other uiItem - use carefully, if you want to display multiple UI scenes at once
func show_ui(UiSceneToShow) -> void:
	for item in uiItems:
		if is_same(UiSceneToShow, item):
			item.show()
		else:
			item.hide()
	
