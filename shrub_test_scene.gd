extends Node2D

signal title
signal intro
signal plan
signal action
signal win
signal lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if !(event is InputEventKey and event.pressed):
		return
	match event.keycode:
		KEY_A: 
			emit_signal("title")
		KEY_S:
			emit_signal("intro")
		KEY_D:
			emit_signal("plan")
		KEY_F:
			emit_signal("action")
		KEY_G:
			emit_signal("win")
		KEY_H:
			emit_signal("lose")
