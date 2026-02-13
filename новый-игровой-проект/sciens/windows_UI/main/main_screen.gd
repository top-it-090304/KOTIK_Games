extends CanvasLayer
class_name UI


const FIRST_MENU : String = "res://sciens/windows_UI/first_screen/first_menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(FIRST_MENU)
	_on_button_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed(): # Button was pressed.
	# Obtain the resource now that we need it.
	var first_scene = ResourceLoader.load_threaded_get(FIRST_MENU)
	# Instantiate the enemy scene and add it to the current scene.
	var enemy = first_scene.instantiate()
	add_child(enemy)
