extends Node
class_name LocalStorage

const PATH := "user://save.json"; #Change the path as you want

var _data: Dictionary = {};

func _init() -> void:
	_load()
	_security()
	randomize()

func set_item(key: String, value) -> void:
	_data[key] = value;
	_save()

func get_item(key: String, default_value = null):
	return _data.get(key, default_value)

func has_item(key: String) -> bool:
	return _data.has(key)

func remove_item(key: String) -> void:
	if _data.has(key):
		_data.erase(key)
		_save()

func clear() -> void:
	_data.clear()
	_save()

func _load() -> void:
	if !FileAccess.file_exists(PATH):
		_save()
		return
	var file = FileAccess.open(PATH, FileAccess.READ);
	var result = JSON.parse_string(file.get_as_text());
	file.close()
	if typeof(result) == TYPE_DICTIONARY:
		_data = result;
	else:
		_data = {};

func _save() -> void:
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(_data))
	file.close()

func _security() -> void:
  if !has_item("money"): set_item("money", 0) #for an example
