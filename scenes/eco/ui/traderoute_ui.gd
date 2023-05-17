extends Control

@onready var route_container_scene = preload("res://scenes/eco/ui/route_container.tscn")
@onready var containers = $Panel/VBoxContainer

func create_routes(route,route_list):
	for j in containers.get_children():
		j.queue_free()
	for i in route_list.keys():
		var route_container = route_container_scene.instantiate()
		var resource = route_list.get(i)
		route_container.set_data(i,route,resource[0], resource[1],resource[2])
		containers.add_child(route_container)
		
func _on_button_pressed() -> void:
	for j in containers.get_children():
		j.queue_free()
	GlobalManager.panel_open = false
	hide()
