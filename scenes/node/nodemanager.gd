extends Node

var node_list: Array
var route_list: Array

var route_id: int = 1

func register_node(node) -> void:
	node_list.append(node)

func register_route(route) -> void:
	route_list.append(route)

func delete_route(route) -> void:
	route_list.erase(route)
	
func _on_game_tick_timeout() -> void:
	for node in node_list:
		node.time_passed()
	for route in route_list:
		route.time_passed()
