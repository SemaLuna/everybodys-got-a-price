extends Node2D

var processing_item = false
@export var speed = 30
signal item_ready

## Pause movement and wait for a signal to release item
func hold_item():
	processing_item = false
	
	# Below is to handle receiving input from machines
	var item = get_child(0) if get_children().size() > 0 else null
	if (item != null): item.show()
	item_ready.emit()
	
## Get item from the previous conveyor belt and move it across this coveyor belt
func receive_item(item: Node2D):
	item.reparent(self, true)
	processing_item = true
	return item
	
## Called when a conveyor belt can receive another item.
func offload_item():
	var item = get_child(0)
	return item
	
func _physics_process(delta):
	## No items on the conveyor or an item is at the end of the conveyor waiting to be offloaded
	if not processing_item or get_child_count() == 0:
		return
	handle_item(delta)

# Overridden in files that extend this one
func handle_item(delta):
	var item = get_child(0) as Node2D
	## Moves items to the edge of conveyor belt
	item.global_position = item.global_position.move_toward(get_parent().global_position, speed * delta)
	## If at the edge of the conveyor belt pauses movement
	if item.global_position == get_parent().global_position:
		hold_item()
