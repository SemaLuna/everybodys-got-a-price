extends Area2D

@onready var item_holder = $ItemHolder
signal increase_score

func can_receive_item():
	return item_holder.get_child_count() == 0
	
func receive_item(item: Node2D):
	item_holder.receive_item(item)
	
func _on_item_holder_item_ready():
	var item = item_holder.offload_item()
	item.queue_free()
	increase_score.emit()
