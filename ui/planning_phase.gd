extends Node2D

@export var grid_cell: PackedScene 
@export var producer: PackedScene
@export var trash: PackedScene
var halfCell = Vector2(32,32)

var MAX_COLUMNS = 14
var ROWS = 7 #Not configured directly, but expected based on container size
var LAST_CELL_INDEX = (MAX_COLUMNS * ROWS) - 1
var producerInstance = null
var trashInstance = null
var building_scene: PackedScene
var direction = null
var build_rotation = 0

func _ready() -> void:
	populate_grid()

func build_mode(is_active: bool, building, turn) -> void:
	building_scene = building if is_active else null
	direction = turn
	toggle_cells(is_active)

func _on_hud_rotation_updated(rotation):
	build_rotation = rotation

func populate_grid() -> void:
	var container = $GridContainer
	container.columns = MAX_COLUMNS
	if not grid_cell || not producer || not trash: return
	
	for i in range(MAX_COLUMNS*ROWS):
		var new_cell : BaseButton = grid_cell.instantiate()
		# All cells start disabled - they become 'enabled' in build mode
		new_cell.disabled = true
		new_cell.pressed.connect(on_cell_pressed.bind(new_cell))
		if (i == 0):
			producerInstance = producer.instantiate()
			new_cell.add_child(producerInstance)
			producerInstance.translate(halfCell)
		else: if (i == LAST_CELL_INDEX):
			trashInstance = trash.instantiate()
			new_cell.add_child(trashInstance)
			trashInstance.translate(halfCell)
		container.add_child(new_cell)

func toggle_cells(is_enabled: bool) -> void:
	var cells = $GridContainer.get_children()
	for i in cells.size():
		# Enable every button in the cell except the initial ones
		if (i != 0) && (i != LAST_CELL_INDEX):
			cells[i].disabled = !is_enabled
		
func on_cell_pressed(cell: BaseButton) -> void:
	# We expect the buttons to have a single child - 
	# the scene representing the machine / belt (or nothing)
	var children = cell.get_children()
	if (children.size() > 0):
		var child = children[0]
		cell.remove_child(child)
	# If null, we are 'erasing' the scene - and nothing else needs to be done
	if building_scene != null:
		var machine_instance = building_scene.instantiate()
		cell.add_child(machine_instance)
		get_parent().get_node("SFXPlayer").play_sfx("SFX - Place.ogg")
		if direction != null:
			if direction == "turn-right":
				machine_instance.set_direction(direction)
			if direction == "turn-left":
				machine_instance.set_direction(direction)
		machine_instance.rotation = build_rotation
		machine_instance.translate(halfCell)
