extends Area2D

signal belt_detected

var detecting = false

func detect(): 
	detecting = true;

func _physics_process(_delta):
	if not detecting:
		return
	var areas = get_overlapping_areas()
	for area in areas:
		if area.can_receive_item():
			belt_detected.emit(area)
			detecting = false
			break
