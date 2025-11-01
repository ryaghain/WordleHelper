extends Control

const WORD_LIST = preload("res://Assets/WordList.json")

#@export var text_edit_character_1_is: TextEdit
#@export var text_edit_character_1_is_not: TextEdit
#@export var text_edit_character_2_is: TextEdit
#@export var text_edit_character_2_is_not: TextEdit
#@export var text_edit_character_3_is: TextEdit
#@export var text_edit_character_3_is_not: TextEdit
#@export var text_edit_character_4_is: TextEdit
#@export var text_edit_character_4_is_not: TextEdit
#@export var text_edit_character_5_is: TextEdit
#@export var text_edit_character_5_is_not: TextEdit
#@export var text_edit_contains_does: TextEdit
#@export var text_edit_contains_does_not: TextEdit
#@export var label_word_list: Label
#
#@onready var character_requirements: Dictionary[int, Dictionary] = {
	#0: {
		#"is": text_edit_character_1_is,
		#"is_not": text_edit_character_1_is_not
	#},
	#1: {
		#"is": text_edit_character_2_is,
		#"is_not": text_edit_character_2_is_not
	#},
	#2: {
		#"is": text_edit_character_3_is,
		#"is_not": text_edit_character_3_is_not
	#},
	#3: {
		#"is": text_edit_character_4_is,
		#"is_not": text_edit_character_4_is_not
	#},
	#4: {
		#"is": text_edit_character_5_is,
		#"is_not": text_edit_character_5_is_not
	#}
#}

var current_word_list: String = ""

#func _ready() -> void:
	#for word: String in WORD_LIST.data:
		#current_word_list += word + "\n"
	#label_word_list.text = current_word_list

#func _on_button_run_pressed() -> void:
	#current_word_list = ""
	#for word: String in WORD_LIST.data:
		#var is_word_valid: bool = true
#
		#for index: int in [0, 1, 2, 3, 4]:
			#var character_requrement_is: String = get_character_requirements(index, true)
			#if not character_requrement_is.is_empty() and word[index] != character_requrement_is:
				#is_word_valid = false
				#break
			#else:
#
				#var character_requrement_is_not: String = get_character_requirements(index, false)
				#if not character_requrement_is_not.is_empty():
					#for character: String in character_requrement_is_not.split(""):
						#if word[index] == character:
							#is_word_valid = false
							#break
#
				#if is_word_valid and not text_edit_contains_does.text.is_empty():
					#for character: String in text_edit_contains_does.text.split(""):
						#if not word.contains(character):
							#is_word_valid = false
							#break
#
				#if is_word_valid and not text_edit_contains_does_not.text.is_empty():
					#for character: String in text_edit_contains_does_not.text.split(""):
						#if word.contains(character):
							#is_word_valid = false
							#break
#
		#if is_word_valid:
			#current_word_list += word + "\n"
#
	#label_word_list.text = current_word_list
#
#func get_character_requirements(index: int, _is: bool) -> String:
	#return character_requirements[index].is.text if _is else character_requirements[index].is_not.text
