extends Panel

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value)

func _on_effects_volum_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)

func _on_dictor_volum_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3,value)
