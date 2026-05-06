extends Control

## 25 分鐘番茄鐘；結束時發放金幣並回到主選單。

const SESSION_SECONDS := 25.0 * 60.0
const EARNED_GOLD := 10

@onready var _timer_label: Label = $VBoxContainer/TimerLabel
@onready var _progress: ProgressBar = $VBoxContainer/ProgressBar
@onready var _character_root: Node2D = $CharacterAnim
@onready var _character_sprite: AnimatedSprite2D = $CharacterAnim/AnimatedSprite2D


var _remaining: float = SESSION_SECONDS


func _ready() -> void:
	_remaining = SESSION_SECONDS
	_progress.max_value = SESSION_SECONDS
	_progress.value = 0.0
	_update_ui()
	_character_root.visible = true
	_character_sprite.stop()
	_character_sprite.play("new_animation")


func _process(delta: float) -> void:
	if _remaining <= 0.0:
		return
	_remaining -= delta
	if _remaining <= 0.0:
		_remaining = 0.0
		_finish_session()
	_update_ui()


func _finish_session() -> void:
	set_process(false)
	Global.complete_focus_session(EARNED_GOLD, SESSION_SECONDS)
	var main := get_tree().get_first_node_in_group("main_scene")
	if main and main.has_method("go_to_start_menu"):
		main.go_to_start_menu()


func _update_ui() -> void:
	var total_sec := int(ceil(_remaining))
	var m := int(total_sec / 60.0)
	var s := total_sec % 60
	_timer_label.text = "%02d:%02d" % [m, s]
	_progress.value = SESSION_SECONDS - _remaining
