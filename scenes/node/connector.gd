extends Line2D

func _process(_delta: float) -> void:
	set_point_position(1, get_local_mouse_position())
	if Input.is_action_just_released("mb_left"):
		queue_free()
	
func body_entered(body) -> void:
	get_parent().movement_finished(body)
	queue_free()
