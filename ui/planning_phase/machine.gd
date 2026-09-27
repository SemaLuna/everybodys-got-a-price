extends "res://ui/planning_phase/item_holder.gd"

# References
# var number_of_frames = 33
# var frames_per_second = 5
var move_vector: Vector2 = Vector2(64.0, 0.0) # Move fully across the machine

# Overridden from parent
func receive_item(item: Node2D):
	super(item)
	var animation = get_parent().find_child('Animation') as AnimatedSprite2D
	animation.play('processing')
	item.hide()
	
# Overridden from parent
func offload_item():
	var item = get_child(0)
	return item

# Overridden parent behaviour
func _physics_process(delta):
	pass

func _on_animation_animation_finished() -> void:
	var item = get_child(0)
	item.position = position + move_vector
	hold_item()
