extends Area2D

@onready var item_holder = $ItemHolder
@onready var detector = $Detector
@onready var sprite = $AnimatedSprite2D
enum Direction {Left, Right, Up, Down}
@export var to_direction: Direction = Direction.Right
@export var from_direction: Direction = Direction.Left

func set_direction():
	## Requires thorough implementation for now it will simple receive from left deposit right
	## the default detector position is centered on the conveyor, we will need to point it towards the next conveyor
	detector.position = Vector2.RIGHT * 64 
	
# Sets the direction for the conveyor at the very start
func _ready():
	set_direction()
	
func can_receive_item():
	return item_holder.get_child_count() == 0
	
func receive_item(item: Node2D):
	item_holder.receive_item(item)

# if an open conveyor belt is detectedit will deliver the item onto the next conveyor
func _on_detector_belt_detected(destination: Area2D):
	var item = item_holder.offload_item()
	destination.receive_item(item)

## checks to see viable conveyor belts to pass item to
func _on_item_holder_item_ready():
	detector.detect()
