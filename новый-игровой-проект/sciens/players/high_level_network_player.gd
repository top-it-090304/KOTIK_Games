extends CharacterBody2D

const SPEED = 300.0

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	velocity = Input.get_vector("L","R","U","D") * SPEED
	
	move_and_slide()
