extends AudioStreamPlayer

var sounds: Dictionary[String, AudioStream]

func _ready() -> void:
	var path = "res://assets/audio/sfx/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !file_name.begins_with("."):
				sounds[file_name] = load(path + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	var path2 = "res://assets/audio/sfx/price/"
	var dir2 = DirAccess.open(path2)
	if dir2:
		dir2.list_dir_begin()
		var file_name = dir2.get_next()
		while file_name != "":
			if !file_name.begins_with("."):
				sounds[file_name] = load(path2 + file_name)
			file_name = dir2.get_next()
	else:
		print("An error occurred when trying to access the path.")

# Called when the node enters the scene tree for the first time.
func play_sfx(name: String):
	stream = sounds[name]
	play()
	
	
