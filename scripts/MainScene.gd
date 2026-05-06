extends Control

const START_MENU := "res://scenes/ui/StartMenu.tscn"
const FOCUS_SCENE := "res://scenes/game/FocusScene.tscn"

@onready var _container: Control = $UIContainer


func _ready() -> void:
	add_to_group("main_scene")
	_switch_to_packed(START_MENU)


func go_to_start_menu() -> void:
	_switch_to_packed(START_MENU)


func go_to_focus() -> void:
	_switch_to_packed(FOCUS_SCENE)


func _switch_to_packed(path: String) -> void:
	for c in _container.get_children():
		c.queue_free()
	var ps: PackedScene = load(path) as PackedScene
	if ps == null:
		push_error("MainScene: failed to load %s" % path)
		return
	_container.add_child(ps.instantiate())
