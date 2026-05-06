extends Control

@onready var _gold_label: Label = $VBoxContainer/GoldLabel
@onready var _start_button: Button = $VBoxContainer/StartButton


func _ready() -> void:
	Global.focus_finished.connect(_on_focus_finished)
	_refresh_gold()
	_start_button.grab_focus()


func _exit_tree() -> void:
	if Global.focus_finished.is_connected(_on_focus_finished):
		Global.focus_finished.disconnect(_on_focus_finished)


func _on_focus_finished(_earned: int) -> void:
	_refresh_gold()


func _refresh_gold() -> void:
	_gold_label.text = "金幣：%d" % Global.gold


func _on_start_button_pressed() -> void:
	var main := get_tree().get_first_node_in_group("main_scene")
	if main and main.has_method("go_to_focus"):
		main.go_to_focus()
