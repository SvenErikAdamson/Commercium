extends HBoxContainer
@onready var node_manager = get_node("/root/Game/World/NodeManager")
var node1
var node2
var resource
var route
var id

func set_data(i,rout,origin, res, destination):
	$Origin.text = str(origin.name) + " -> "
	$Resource.text = str(res) + " -> "
	$Destination.text = str(destination.name)
	node1 = origin
	node2 = destination
	resource = res
	route = rout
	id = i

func _on_button_pressed() -> void:
	node1.resource_list.append(resource)
	if route.resource_list.has(id):
		route.resource_list.erase(id)
		route.update_traderoute_panel()
		node1.draw_resources()
		node2.draw_resources()
		node1.tradepartners.erase(node2)
		node2.tradepartners.erase(node1)
		if route.resource_list.is_empty():
			route.update_traderoute_panel()
			node_manager.delete_route(route)
			route.queue_free()

