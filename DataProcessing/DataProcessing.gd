@tool
extends Node

const FILTERED_DATA_FILE = preload("res://Assets/FilteredData.json")

@export var word_list: JSON
@export var raw_data_folder_path: String = ""
@export_tool_button("Process Raw Data") var process_raw_data = _process_raw_data
@export_tool_button("Convert String To Dict") var convert_string_to_dict = _convert_string_to_dict
@export_tool_button("Filter Data") var filter_data = _filter_data
@export_tool_button("Run") var run = _run
@export_group("Single Word")
@export var single_word: String
@export_tool_button("Run Single Word") var run_single_word = _run_single_word

var raw_data_strings: Array[String] = []
var unfiltered_data: Dictionary[String, Array] = {}
var filtered_data: Dictionary[String, float] = {}

func _ready() -> void:
	if not Engine.is_editor_hint():
		get_viewport().visible = false
		_run()
		get_tree().quit()

func _run() -> void:
	_process_raw_data()
	_convert_string_to_dict()
	_filter_data()

func _run_single_word() -> void:
	if not single_word.is_empty():
		_process_raw_data()
		_convert_string_to_dict()
		_get_single_word_data()

func _process_raw_data() -> void:
	for file_path: String in DirAccess.get_files_at(raw_data_folder_path):
		var data_string: String = FileAccess.get_file_as_string(raw_data_folder_path + "/" + file_path)
		print("File '%s' string length: %s" % [file_path, data_string.length()])
		raw_data_strings.append(data_string)

	print("\nSource file count: %s\n" % raw_data_strings.size())

func _convert_string_to_dict() -> void:
	for file_string: String in raw_data_strings:
		var file_lines: PackedStringArray = file_string.split("\n")
		print("File line count: %s" % file_lines.size())

		for file_line: String in file_lines:
			var string_data: PackedStringArray = file_line.split("\t")

			if string_data.size() == 3:
				var word: String = string_data[1]

				if unfiltered_data.has(word):
					unfiltered_data[word].append(int(string_data[2]))
				else:
					unfiltered_data[word] = [int(string_data[2])]

	print("\nUnfiltered data size: %s\n" % unfiltered_data.size())

func _filter_data() -> void:
	for word: String in unfiltered_data.keys():
		if word_list.data.has(word):
			var average_frequency: float = 0.0
			var frequencies: Array = unfiltered_data[word]

			for n: int in frequencies:
				average_frequency += n
			average_frequency = roundf(average_frequency / float(frequencies.size()))

			filtered_data[word] = average_frequency
			print("%s: %s" % [word, average_frequency])

	print("\nFiltered data size: %s\n" % filtered_data.size())

	var file: FileAccess = FileAccess.open("res://Assets/FilteredData.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(filtered_data, "\t"))
	file.flush()
	file.close()

	print("Saved data to 'res://Assets/FilteredData.json'.")

func _get_single_word_data() -> void:
	if unfiltered_data.has(single_word):
		var average_frequency: float = 0.0
		var frequencies: Array = unfiltered_data[single_word]

		for n: int in frequencies:
			average_frequency += n
		average_frequency = roundf(average_frequency / float(frequencies.size()))

		print("%s: %s" % [single_word, average_frequency])

		var existing_data: Dictionary = FILTERED_DATA_FILE.data
		existing_data[single_word] = average_frequency
		var file: FileAccess = FileAccess.open("res://Assets/FilteredData.json", FileAccess.WRITE)
		print("Opening FilteredData.json: %s" % error_string(FileAccess.get_open_error()))
		file.store_line(JSON.stringify(existing_data, "\t"))
		file.flush()
		file.close()
