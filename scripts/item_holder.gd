extends Node2D

var moving_item = false
@export var speed = 30
signal item_ready

## Pause movement and wait for a signal to release item
func hold_item():
	moving_item = false
	emit_signal("item_ready")
	
## Get item from the previous conveyor belt and move it across this coveyor belt
func receive_item(item: Node2D):
	item.reparent(self, true)
	moving_item = true
	
	## Called when a conveyor belt can recieve another item.
func offload_item():
	var item = get_child(0)
	return item
	
func _physics_process(delta):
	## No items on the conveyor or an item is at the end of the conveyor waiting to be offloaded
	if not moving_item or get_child_count() == 0:
		return
	var item = get_child(0)
	if item is Node2D: ## Is this necessary?
		## Moves items to the edge of conveyor belt
		item.global_position = item.global_position.move_toward(get_parent().global_position,
				 speed * delta)
		## If at the edge of the conveyor belt pauses movement
		if item.global_position == get_parent().global_position:
			hold_item()
	 
	
