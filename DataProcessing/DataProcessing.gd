@tool
extends Node

@export var word_list: JSON
@export_file_path("*.txt") var raw_data_file_path
@export_tool_button("Process Raw Data") var process_raw_data = _process_raw_data
@export_tool_button("Convert String To Dict") var convert_string_to_dict = _convert_string_to_dict
@export_tool_button("Filter Data") var filter_data = _filter_data
@export_tool_button("Run") var run = _run

var raw_data_string: String
var data: Dictionary[String, int] = {}
var filtered_data: Dictionary[String, int] = {}

func _run() -> void:
	_process_raw_data()
	_convert_string_to_dict()
	_filter_data()

func _process_raw_data() -> void:
	raw_data_string = FileAccess.get_file_as_string(raw_data_file_path)

func _convert_string_to_dict() -> void:
	#var slice_count: int = raw_data_string.get_slice_count("\n")
	#print("slice count: %s" % slice_count)
	for substring: String in raw_data_string.split("\n"):
		var substring_data: PackedStringArray = substring.split("\t")
		data[substring_data[1]] = int(substring_data[2])

func _filter_data() -> void:
	for word: String in data.keys():
		if word_list.data.has(word):
			filtered_data[word] = data[word]

	print(filtered_data.size())

	var file: FileAccess = FileAccess.open("res://Assets/FilteredData.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(filtered_data, "\t"))
	file.flush()
	file.close()
