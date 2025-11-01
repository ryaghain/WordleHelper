@tool
class_name GridHelper extends GridContainer

@export var change_minimum_size: bool:
	set(value):
		_update_minimum_size(new_minimum_size)
@export var new_minimum_size: Vector2
@export var change_placeholder_text: bool:
	set(value):
		_update_text(new_placeholder_text)
@export var new_placeholder_text: String

func _update_minimum_size(new_size: Vector2) -> void:
	for child: Control in get_children():
		child.custom_minimum_size = new_size
		child.size_flags_horizontal = Control.SIZE_EXPAND
		child.size_flags_vertical = Control.SIZE_EXPAND
		child.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		child.size_flags_vertical = Control.SIZE_SHRINK_CENTER

func _update_text(new_text: String) -> void:
	for child: Control in get_children():
		child.placeholder_text = new_text
