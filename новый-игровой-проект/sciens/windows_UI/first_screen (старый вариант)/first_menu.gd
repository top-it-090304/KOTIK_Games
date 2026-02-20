extends Control

const CHOICE_MENU : String = "res://sciens/windows_UI/choice_screen/choice_menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(CHOICE_MENU)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed(): # Button was pressed.
	# Obtain the resource now that we need it.
	var choice_menu_scene = ResourceLoader.load_threaded_get(CHOICE_MENU)
	# Instantiate the enemy scene and add it to the current scene.
	$CenterContainer.visible = false
	var enemy = choice_menu_scene.instantiate()
	add_child(enemy)
