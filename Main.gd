class_name Main extends Control

enum STATE {
	DEFAULT,
	PAINTING_BLACK,
	PAINTING_GREY,
	PAINTING_YELLOW,
	PAINTING_GREEN
}

enum LETTER_COLORS {
	EMPTY,
	GREY,
	YELLOW,
	GREEN
}

const LETTER_COLOR_EMPTY: Color = Color("151515ff")
const LETTER_COLOR_GREY: Color = Color("3a3a3cff")
const LETTER_COLOR_YELLOW: Color = Color("b59f3bff")
const LETTER_COLOR_GREEN: Color = Color("538d4eff")

const WORD_LIST = preload("res://Assets/WordList.json")

const LETTER_POSITIONS: Array[int] = [1, 2, 3, 4, 5]
const WORD_POSITIONS: Array[int] = [1, 2, 3, 4, 5, 6]

const LETTER_FREQUENCY: Dictionary[String, int] = {
	"e": 26,
	"t": 25,
	"a": 24,
	"o": 23,
	"i": 22,
	"n": 21,
	"s": 20,
	"h": 19,
	"r": 18,
	"d": 17,
	"l": 16,
	"c": 15,
	"u": 14,
	"m": 13,
	"w": 12,
	"f": 11,
	"g": 10,
	"y": 9,
	"p": 8,
	"b": 7,
	"v": 6,
	"k": 5,
	"j": 4,
	"x": 3,
	"q": 2,
	"z": 1,
}

@export var label_word_count: Label
@export var label_word_list: Label
@export_group("LineEdits")
@export_subgroup("Word 1")
@export var line_edit_word_1_letter_1: LineEdit
@export var line_edit_word_1_letter_2: LineEdit
@export var line_edit_word_1_letter_3: LineEdit
@export var line_edit_word_1_letter_4: LineEdit
@export var line_edit_word_1_letter_5: LineEdit
@export_subgroup("Word 2")
@export var line_edit_word_2_letter_1: LineEdit
@export var line_edit_word_2_letter_2: LineEdit
@export var line_edit_word_2_letter_3: LineEdit
@export var line_edit_word_2_letter_4: LineEdit
@export var line_edit_word_2_letter_5: LineEdit
@export_subgroup("Word 3")
@export var line_edit_word_3_letter_1: LineEdit
@export var line_edit_word_3_letter_2: LineEdit
@export var line_edit_word_3_letter_3: LineEdit
@export var line_edit_word_3_letter_4: LineEdit
@export var line_edit_word_3_letter_5: LineEdit
@export_subgroup("Word 4")
@export var line_edit_word_4_letter_1: LineEdit
@export var line_edit_word_4_letter_2: LineEdit
@export var line_edit_word_4_letter_3: LineEdit
@export var line_edit_word_4_letter_4: LineEdit
@export var line_edit_word_4_letter_5: LineEdit
@export_subgroup("Word 5")
@export var line_edit_word_5_letter_1: LineEdit
@export var line_edit_word_5_letter_2: LineEdit
@export var line_edit_word_5_letter_3: LineEdit
@export var line_edit_word_5_letter_4: LineEdit
@export var line_edit_word_5_letter_5: LineEdit
@export_subgroup("Word 6")
@export var line_edit_word_6_letter_1: LineEdit
@export var line_edit_word_6_letter_2: LineEdit
@export var line_edit_word_6_letter_3: LineEdit
@export var line_edit_word_6_letter_4: LineEdit
@export var line_edit_word_6_letter_5: LineEdit
@export_group("TextureButtons")
@export var texture_button_black: TextureButton
@export var texture_button_grey: TextureButton
@export var texture_button_yellow: TextureButton
@export var texture_button_green: TextureButton

var style_box_default: StyleBoxFlat
var style_box_grey: StyleBoxFlat
var style_box_yellow: StyleBoxFlat
var style_box_green: StyleBoxFlat

## Column-major.
@onready var line_edits: Dictionary[int, Dictionary] = {
	1: {
		1: line_edit_word_1_letter_1,
		2: line_edit_word_2_letter_1,
		3: line_edit_word_3_letter_1,
		4: line_edit_word_4_letter_1,
		5: line_edit_word_5_letter_1,
		6: line_edit_word_6_letter_1
	},
	2: {
		1: line_edit_word_1_letter_2,
		2: line_edit_word_2_letter_2,
		3: line_edit_word_3_letter_2,
		4: line_edit_word_4_letter_2,
		5: line_edit_word_5_letter_2,
		6: line_edit_word_6_letter_2
	},
	3: {
		1: line_edit_word_1_letter_3,
		2: line_edit_word_2_letter_3,
		3: line_edit_word_3_letter_3,
		4: line_edit_word_4_letter_3,
		5: line_edit_word_5_letter_3,
		6: line_edit_word_6_letter_3
	},
	4: {
		1: line_edit_word_1_letter_4,
		2: line_edit_word_2_letter_4,
		3: line_edit_word_3_letter_4,
		4: line_edit_word_4_letter_4,
		5: line_edit_word_5_letter_4,
		6: line_edit_word_6_letter_4
	},
	5: {
		1: line_edit_word_1_letter_5,
		2: line_edit_word_2_letter_5,
		3: line_edit_word_3_letter_5,
		4: line_edit_word_4_letter_5,
		5: line_edit_word_5_letter_5,
		6: line_edit_word_6_letter_5
	}
}

var current_state: STATE = STATE.DEFAULT

## Column-major.
var current_letter_colors: Dictionary[int, Dictionary] = {
	1: {
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY,
		6: LETTER_COLORS.EMPTY
	},
	2: {
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY,
		6: LETTER_COLORS.EMPTY
	},
	3: {
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY,
		6: LETTER_COLORS.EMPTY
	},
	4: {
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY,
		6: LETTER_COLORS.EMPTY
	},
	5: {
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY,
		6: LETTER_COLORS.EMPTY
	}
}

@onready var line_edit_array: Array[LineEdit] = [
	line_edit_word_1_letter_1,
	line_edit_word_1_letter_2,
	line_edit_word_1_letter_3,
	line_edit_word_1_letter_4,
	line_edit_word_1_letter_5,
	line_edit_word_2_letter_1,
	line_edit_word_2_letter_2,
	line_edit_word_2_letter_3,
	line_edit_word_2_letter_4,
	line_edit_word_2_letter_5,
	line_edit_word_3_letter_1,
	line_edit_word_3_letter_2,
	line_edit_word_3_letter_3,
	line_edit_word_3_letter_4,
	line_edit_word_3_letter_5,
	line_edit_word_4_letter_1,
	line_edit_word_4_letter_2,
	line_edit_word_4_letter_3,
	line_edit_word_4_letter_4,
	line_edit_word_4_letter_5,
	line_edit_word_5_letter_1,
	line_edit_word_5_letter_2,
	line_edit_word_5_letter_3,
	line_edit_word_5_letter_4,
	line_edit_word_5_letter_5,
	line_edit_word_6_letter_1,
	line_edit_word_6_letter_2,
	line_edit_word_6_letter_3,
	line_edit_word_6_letter_4,
	line_edit_word_6_letter_5
]

var current_line_edit_index: int = 0

var current_word_list: String = ""

func _ready() -> void:
	style_box_default = line_edit_word_1_letter_1.get_theme_stylebox(&"normal")

	style_box_grey = style_box_default.duplicate(true)
	style_box_grey.bg_color = LETTER_COLOR_GREY

	style_box_yellow = style_box_default.duplicate(true)
	style_box_yellow.bg_color = LETTER_COLOR_YELLOW

	style_box_green = style_box_default.duplicate(true)
	style_box_green.bg_color = LETTER_COLOR_GREEN

	for letter_column in LETTER_POSITIONS:
		for word_row in WORD_POSITIONS:
			var line_edit: LineEdit = line_edits[letter_column][word_row]
			line_edit.add_theme_stylebox_override(&"normal", line_edit.get_theme_stylebox(&"normal").duplicate())

	var word_count: int = 0
	for word: String in WORD_LIST.data:
		current_word_list += word + "\n"
		word_count += 1
	update_displayed_word_list(word_count)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_BACKSPACE:
			current_line_edit_index = maxi(0, current_line_edit_index - 1)
			line_edit_array[current_line_edit_index].text = ""
		else:
			line_edit_array[current_line_edit_index].text = OS.get_keycode_string(event.keycode)
			current_line_edit_index = mini(current_line_edit_index + 1, 29)

func _on_button_reset_pressed() -> void:
	current_state = STATE.PAINTING_BLACK
	for letter_column: int in LETTER_POSITIONS:
		for word_row: int in WORD_POSITIONS:
			var line_edit: LineEdit = line_edits[letter_column][word_row]
			line_edit.text = ""
			paint_letter_color(letter_column, word_row, line_edit, false)
	current_state = STATE.DEFAULT
	texture_button_black.button_pressed = false
	texture_button_grey.button_pressed = false
	texture_button_yellow.button_pressed = false
	texture_button_green.button_pressed = false
	update_word_list()

func _on_button_quit_pressed() -> void:
	get_tree().quit()

func _on_line_edit_gui_input(event: InputEvent, word_row: int, letter_column: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		var line_edit: LineEdit = line_edits[letter_column][word_row]
		if current_state != STATE.DEFAULT:
			line_edit.editable = false
			line_edit.release_focus()
			paint_letter_color(letter_column, word_row, line_edit)
		else:
			line_edit.editable = true

func _on_line_edit_text_changed(new_text: String, source: LineEdit) -> void:
	source.text = new_text.to_upper()

func _on_texture_button_black_toggled(toggled_on: bool) -> void:
	if toggled_on:
		match current_state:
			STATE.PAINTING_GREY:
				texture_button_grey.button_pressed = false
			STATE.PAINTING_YELLOW:
				texture_button_yellow.button_pressed = false
			STATE.PAINTING_GREEN:
				texture_button_green.button_pressed = false
		current_state = STATE.PAINTING_BLACK
	else:
		current_state = STATE.DEFAULT

func _on_texture_button_grey_toggled(toggled_on: bool) -> void:
	if toggled_on:
		match current_state:
			STATE.PAINTING_BLACK:
				texture_button_black.button_pressed = false
			STATE.PAINTING_YELLOW:
				texture_button_yellow.button_pressed = false
			STATE.PAINTING_GREEN:
				texture_button_green.button_pressed = false
		current_state = STATE.PAINTING_GREY
	else:
		current_state = STATE.DEFAULT

func _on_texture_button_yellow_toggled(toggled_on: bool) -> void:
	if toggled_on:
		match current_state:
			STATE.PAINTING_BLACK:
				texture_button_black.button_pressed = false
			STATE.PAINTING_GREY:
				texture_button_grey.button_pressed = false
			STATE.PAINTING_GREEN:
				texture_button_green.button_pressed = false
		current_state = STATE.PAINTING_YELLOW
	else:
		current_state = STATE.DEFAULT

func _on_texture_button_green_toggled(toggled_on: bool) -> void:
	if toggled_on:
		match current_state:
			STATE.PAINTING_BLACK:
				texture_button_black.button_pressed = false
			STATE.PAINTING_GREY:
				texture_button_grey.button_pressed = false
			STATE.PAINTING_YELLOW:
				texture_button_yellow.button_pressed = false
		current_state = STATE.PAINTING_GREEN
	else:
		current_state = STATE.DEFAULT

func paint_letter_color(letter_column: int, word_row: int, line_edit: LineEdit, do_update: bool = true) -> void:
	match current_state:
		STATE.PAINTING_BLACK:
			current_letter_colors[letter_column][word_row] = LETTER_COLORS.EMPTY
			line_edit.add_theme_stylebox_override(&"focus", style_box_default)
			line_edit.add_theme_stylebox_override(&"normal", style_box_default)
			line_edit.add_theme_stylebox_override(&"read_only", style_box_default)
		STATE.PAINTING_GREY:
			current_letter_colors[letter_column][word_row] = LETTER_COLORS.GREY
			line_edit.add_theme_stylebox_override(&"focus", style_box_grey)
			line_edit.add_theme_stylebox_override(&"normal", style_box_grey)
			line_edit.add_theme_stylebox_override(&"read_only", style_box_grey)
		STATE.PAINTING_YELLOW:
			current_letter_colors[letter_column][word_row] = LETTER_COLORS.YELLOW
			line_edit.add_theme_stylebox_override(&"focus", style_box_yellow)
			line_edit.add_theme_stylebox_override(&"normal", style_box_yellow)
			line_edit.add_theme_stylebox_override(&"read_only", style_box_yellow)
		STATE.PAINTING_GREEN:
			current_letter_colors[letter_column][word_row] = LETTER_COLORS.GREEN
			line_edit.add_theme_stylebox_override(&"focus", style_box_green)
			line_edit.add_theme_stylebox_override(&"normal", style_box_green)
			line_edit.add_theme_stylebox_override(&"read_only", style_box_green)

	if do_update:
		update_word_list()

func sort_descending(a: int, b: int) -> bool: return a > b

func update_word_list() -> void:
	var word_count: int = 0

	var letters_is: Dictionary[int, String] = {
		1: "",
		2: "",
		3: "",
		4: "",
		5: ""
	}
	var letters_is_not: Dictionary[int, Array] = {
		1: [],
		2: [],
		3: [],
		4: [],
		5: []
	}
	var word_contains: Array[String] = []
	var word_does_not_contain: Array[String] = []

	for letter_column: int in current_letter_colors.keys():
		for word_row: int in WORD_POSITIONS:
			var letter: String = line_edits[letter_column][word_row].text
			if not letter.is_empty():
				letter = letter.to_lower()
				match current_letter_colors[letter_column][word_row]:
					LETTER_COLORS.GREY:
						if not word_does_not_contain.has(letter):
							word_does_not_contain.append(letter)
					LETTER_COLORS.YELLOW:
						if not letters_is_not[letter_column].has(letter):
							letters_is_not[letter_column].append(letter)
						if not word_contains.has(letter):
							word_contains.append(letter)
					LETTER_COLORS.GREEN:
						if letters_is[letter_column].is_empty():
							letters_is[letter_column] = letter

	current_word_list = ""

	var ranked_word_strings: Dictionary[int, String] = {}

	for word: String in WORD_LIST.data:
		var is_word_valid: bool = true

		for letter_position: int in LETTER_POSITIONS:
			if not letters_is[letter_position].is_empty() and word[letter_position - 1] != letters_is[letter_position]:
				is_word_valid = false
				break

			if not letters_is_not[letter_position].is_empty():
				for letter: String in letters_is_not[letter_position]:
					if word[letter_position - 1] == letter:
						is_word_valid = false
						break

			if not word_contains.is_empty():
				for letter: String in word_contains:
					if not word.contains(letter):
						is_word_valid = false
						break

			if not word_does_not_contain.is_empty():
				for letter: String in word_does_not_contain:
					if word.contains(letter):
						is_word_valid = false
						break

		if is_word_valid:
			var word_score: int = 0
			var word_score_tracker: Array[String] = []

			for letter: String in word:
				if not word_score_tracker.has(letter):
					word_score_tracker.append(letter)
					word_score += LETTER_FREQUENCY[letter]

			if ranked_word_strings.has(word_score):
				ranked_word_strings[word_score] += word + "\n"
			else:
				ranked_word_strings[word_score] = word + "\n"

			word_count += 1

	var ranked_word_scores: Array[int] = ranked_word_strings.keys()
	ranked_word_scores.sort_custom(sort_descending)
	for key: int in ranked_word_scores:
		current_word_list += ranked_word_strings[key]

	update_displayed_word_list(word_count)

func update_displayed_word_list(word_count: int) -> void:
	label_word_list.text = current_word_list.strip_edges()
	label_word_count.text = str(word_count)
