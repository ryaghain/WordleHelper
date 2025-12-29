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

const GRID_WIDTH: Array[int] = [0, 1, 2, 3, 4]
const GRID_HEIGHT: Array[int] = [0, 1, 2, 3, 4, 5]

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
@export_group("Letter Buttons")
@export_subgroup("Word 1")
@export var button_letter_0_0: Button
@export var button_letter_1_0: Button
@export var button_letter_2_0: Button
@export var button_letter_3_0: Button
@export var button_letter_4_0: Button
@export_subgroup("Word 2")
@export var button_letter_0_1: Button
@export var button_letter_1_1: Button
@export var button_letter_2_1: Button
@export var button_letter_3_1: Button
@export var button_letter_4_1: Button
@export_subgroup("Word 3")
@export var button_letter_0_2: Button
@export var button_letter_1_2: Button
@export var button_letter_2_2: Button
@export var button_letter_3_2: Button
@export var button_letter_4_2: Button
@export_subgroup("Word 4")
@export var button_letter_0_3: Button
@export var button_letter_1_3: Button
@export var button_letter_2_3: Button
@export var button_letter_3_3: Button
@export var button_letter_4_3: Button
@export_subgroup("Word 5")
@export var button_letter_0_4: Button
@export var button_letter_1_4: Button
@export var button_letter_2_4: Button
@export var button_letter_3_4: Button
@export var button_letter_4_4: Button
@export_subgroup("Word 6")
@export var button_letter_0_5: Button
@export var button_letter_1_5: Button
@export var button_letter_2_5: Button
@export var button_letter_3_5: Button
@export var button_letter_4_5: Button
@export_group("TextureButtons")
@export var texture_button_black: TextureButton
@export var texture_button_grey: TextureButton
@export var texture_button_yellow: TextureButton
@export var texture_button_green: TextureButton

var style_box_default: StyleBoxFlat
var style_box_grey: StyleBoxFlat
var style_box_yellow: StyleBoxFlat
var style_box_green: StyleBoxFlat

@onready var button_dict: Dictionary[int, Dictionary] = {
	0: {
		0: button_letter_0_0,
		1: button_letter_0_1,
		2: button_letter_0_2,
		3: button_letter_0_3,
		4: button_letter_0_4,
		5: button_letter_0_5
	},
	1: {
		0: button_letter_1_0,
		1: button_letter_1_1,
		2: button_letter_1_2,
		3: button_letter_1_3,
		4: button_letter_1_4,
		5: button_letter_1_5
	},
	2: {
		0: button_letter_2_0,
		1: button_letter_2_1,
		2: button_letter_2_2,
		3: button_letter_2_3,
		4: button_letter_2_4,
		5: button_letter_2_5
	},
	3: {
		0: button_letter_3_0,
		1: button_letter_3_1,
		2: button_letter_3_2,
		3: button_letter_3_3,
		4: button_letter_3_4,
		5: button_letter_3_5
	},
	4: {
		0: button_letter_4_0,
		1: button_letter_4_1,
		2: button_letter_4_2,
		3: button_letter_4_3,
		4: button_letter_4_4,
		5: button_letter_4_5
	}
}

var current_state: STATE = STATE.DEFAULT

## Column-major.
var current_letter_colors: Dictionary[int, Dictionary] = {
	0: {
		0: LETTER_COLORS.EMPTY,
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY
	},
	1: {
		0: LETTER_COLORS.EMPTY,
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY
	},
	2: {
		0: LETTER_COLORS.EMPTY,
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY
	},
	3: {
		0: LETTER_COLORS.EMPTY,
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY
	},
	4: {
		0: LETTER_COLORS.EMPTY,
		1: LETTER_COLORS.EMPTY,
		2: LETTER_COLORS.EMPTY,
		3: LETTER_COLORS.EMPTY,
		4: LETTER_COLORS.EMPTY,
		5: LETTER_COLORS.EMPTY
	}
}

@onready var button_array: Array[Button] = [
	button_letter_0_0,
	button_letter_1_0,
	button_letter_2_0,
	button_letter_3_0,
	button_letter_4_0,
	button_letter_0_1,
	button_letter_1_1,
	button_letter_2_1,
	button_letter_3_1,
	button_letter_4_1,
	button_letter_0_2,
	button_letter_1_2,
	button_letter_2_2,
	button_letter_3_2,
	button_letter_4_2,
	button_letter_0_3,
	button_letter_1_3,
	button_letter_2_3,
	button_letter_3_3,
	button_letter_4_3,
	button_letter_0_4,
	button_letter_1_4,
	button_letter_2_4,
	button_letter_3_4,
	button_letter_4_4,
	button_letter_0_5,
	button_letter_1_5,
	button_letter_2_5,
	button_letter_3_5,
	button_letter_4_5
]

var current_button_index: int = 0

var current_word_list: String = ""

func _ready() -> void:
	style_box_default = button_letter_0_0.get_theme_stylebox(&"normal")

	style_box_grey = style_box_default.duplicate(true)
	style_box_grey.bg_color = LETTER_COLOR_GREY

	style_box_yellow = style_box_default.duplicate(true)
	style_box_yellow.bg_color = LETTER_COLOR_YELLOW

	style_box_green = style_box_default.duplicate(true)
	style_box_green.bg_color = LETTER_COLOR_GREEN

	for letter_column in GRID_WIDTH:
		for word_row in GRID_HEIGHT:
			var button: Button = button_dict[letter_column][word_row]
			button.add_theme_stylebox_override(&"normal", button.get_theme_stylebox(&"normal").duplicate())

	var word_count: int = 0
	for word: String in WORD_LIST.data:
		current_word_list += word + "\n"
		word_count += 1
	update_displayed_word_list(word_count)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_BACKSPACE:
			current_button_index = maxi(0, current_button_index - 1)
			button_array[current_button_index].text = " "
		else:
			button_array[current_button_index].text = OS.get_keycode_string(event.keycode)
			current_button_index = mini(current_button_index + 1, 29)

func _on_button_reset_pressed() -> void:
	current_state = STATE.PAINTING_BLACK
	for x: int in GRID_WIDTH:
		for y: int in GRID_HEIGHT:
			var button: Button = button_dict[x][y]
			button.text = " "
			update_letter_color(x, y, button, false)
	current_state = STATE.DEFAULT
	texture_button_black.button_pressed = false
	texture_button_grey.button_pressed = false
	texture_button_yellow.button_pressed = false
	texture_button_green.button_pressed = false
	update_word_list()

func _on_button_quit_pressed() -> void:
	get_tree().quit()

func _on_button_letter_pressed(location: Vector2i) -> void:
	var button: Button = button_dict[location.x][location.y]
	if current_state != STATE.DEFAULT:
		button.release_focus()
		update_letter_color(location.x, location.y, button)

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

func sort_descending(a: int, b: int) -> bool: return a > b

func update_word_list() -> void:
	var word_count: int = 0

	var letters_is: Dictionary[int, Dictionary] = {
		0: {},
		1: {},
		2: {},
		3: {},
		4: {}
	}
	var letters_is_not: Dictionary[int, Dictionary] = {
		0: {},
		1: {},
		2: {},
		3: {},
		4: {}
	}
	var word_contains: Array[String] = []
	var word_does_not_contain: Array[String] = []

	for x: int in current_letter_colors.keys():
		for y: int in GRID_HEIGHT:
			var letter: String = button_dict[x][y].text
			if not letter.is_empty():
				letter = letter.to_lower()
				match current_letter_colors[x][y]:
					LETTER_COLORS.GREY:
						if not word_does_not_contain.has(letter):
							word_does_not_contain.append(letter)
					LETTER_COLORS.YELLOW:
						letters_is_not[x][letter] = y
						if not word_contains.has(letter):
							word_contains.append(letter)
					LETTER_COLORS.GREEN:
						letters_is[x][letter] = y

	current_word_list = ""

	var ranked_word_strings: Dictionary[int, String] = {}

	for word: String in WORD_LIST.data:
		var is_word_valid: bool = true

		for letter_position: int in GRID_WIDTH:
			# If this position has a green letter, skip the word if the current word's letter in that position does not match.
			if not letters_is[letter_position].is_empty() and word[letter_position] != letters_is[letter_position].keys()[0]:
				is_word_valid = false
				break

			# If this position has a yellow letter, skip the word if the current word's letter in that position matches.
			if not letters_is_not[letter_position].is_empty():
				for letter: String in letters_is_not[letter_position].keys():
					if word[letter_position] == letter:
						is_word_valid = false
						break

			if not word_contains.is_empty():
				for letter: String in word_contains:
					var modified_word: String = word
					# Check if the green letter is in the same row as the yellow letter, and if so removes that letter from that position in the word.
					if letters_is[letter_position].has(letter) and letters_is[letter_position][letter] == letters_is_not[letter_position][letter]:
						modified_word.erase(letter_position)
					if not modified_word.contains(letter):
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

func update_letter_color(x: int, y: int, button: Button, do_update: bool = true) -> void:
	match current_state:
		STATE.PAINTING_BLACK:
			current_letter_colors[x][y] = LETTER_COLORS.EMPTY
			button.add_theme_stylebox_override(&"focus", style_box_default)
			button.add_theme_stylebox_override(&"normal", style_box_default)
			button.add_theme_stylebox_override(&"pressed", style_box_default)
		STATE.PAINTING_GREY:
			current_letter_colors[x][y] = LETTER_COLORS.GREY
			button.add_theme_stylebox_override(&"focus", style_box_grey)
			button.add_theme_stylebox_override(&"normal", style_box_grey)
			button.add_theme_stylebox_override(&"pressed", style_box_grey)
		STATE.PAINTING_YELLOW:
			current_letter_colors[x][y] = LETTER_COLORS.YELLOW
			button.add_theme_stylebox_override(&"focus", style_box_yellow)
			button.add_theme_stylebox_override(&"normal", style_box_yellow)
			button.add_theme_stylebox_override(&"pressed", style_box_yellow)
		STATE.PAINTING_GREEN:
			current_letter_colors[x][y] = LETTER_COLORS.GREEN
			button.add_theme_stylebox_override(&"focus", style_box_green)
			button.add_theme_stylebox_override(&"normal", style_box_green)
			button.add_theme_stylebox_override(&"pressed", style_box_green)

	if do_update:
		update_word_list()
