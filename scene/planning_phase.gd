extends Node2D

@export var grid_cell: PackedScene 
@export var producer: PackedScene
@export var trash: PackedScene
@export var belt: PackedScene
var halfCell = Vector2(32,32)

var MAX_COLUMNS = 14
var ROWS = 7 #Not configured directly, but expected based on container size
var producerInstance = null
var trashInstance = null

func _ready() -> void:
	populate_grid()

func populate_grid() -> void:
	var container = $GridContainer
	container.columns = MAX_COLUMNS
	if not grid_cell || not producer || not trash: return
	
	for i in range(MAX_COLUMNS*ROWS):
		var newCell = grid_cell.instantiate()
		if (i == 0):
			producerInstance = producer.instantiate()
			newCell.add_child(producerInstance)
			producerInstance.translate(halfCell)
		else: if (i == (MAX_COLUMNS - 1)):
			trashInstance = trash.instantiate()
			newCell.add_child(trashInstance)
			trashInstance.translate(halfCell)
		else: if (i < MAX_COLUMNS - 1):
			var beltInstance = belt.instantiate()
			newCell.add_child(beltInstance)
			beltInstance.translate(halfCell)
			beltInstance.add_to_group("Conveyors")
		container.add_child(newCell)
