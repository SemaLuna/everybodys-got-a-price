extends "res://ui/planning_phase/item_holder.gd"

var number_of_frames = 33
@export var processing_time: float = number_of_frames / 5.0

# Overridden from parent
func receive_item(item: Node2D):
	super(item)
	item.hide()

# Overridden from parent
func handle_item(_unused):
	var animation = self.get_parent().find_child('Animation') as AnimatedSprite2D
	animation.play('processing')
	await get_tree().create_timer(processing_time).timeout
	animation.stop()
	hold_item()
