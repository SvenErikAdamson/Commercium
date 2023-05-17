extends Node2D

@onready var traderoute_scene = preload("res://scenes/eco/traderoute.tscn")
@onready var node_manager = get_node("/root/Game/World/NodeManager")
var start_pos
var home_node
var target_node
var traderoute

var res_name: String
var value: int

var is_held: bool = false
var on_node: bool = false

func _ready() -> void:
	start_pos = position

func _process(_delta: float) -> void:
	if Input.is_action_just_released("mb_left") && on_node && is_held && target_node != null:
			check_tradepartners()
	if Input.is_action_just_released("mb_left") && is_held:
			is_held = false
	if is_held:
		position = get_global_mouse_position()
	else:
		position = start_pos
		
func check_tradepartners():
	if home_node.tradepartners.has(target_node) && target_node.tradepartners.has(home_node):
		var route = home_node.tradepartners[target_node]
		route.set_route(node_manager.route_id,home_node,res_name,target_node)
		home_node.resource_list.erase(res_name)
		node_manager.route_id +=1
		queue_free()

#	elif target_node.tradepartners.has(home_node) && home_node.tradepartners.has(target_node):
#		home_node.tradepartners[target_node].set_route(target_node,res_name,home_node)
		
	elif !home_node.tradepartners.has(target_node) || !target_node.tradepartners.has(home_node):
		traderoute = traderoute_scene.instantiate()
		traderoute.set_positions(home_node,target_node )
		traderoute.set_route(node_manager.route_id,home_node,res_name,target_node)
		node_manager.route_id +=1
		home_node.set_tradepartner(target_node, traderoute)
		target_node.set_tradepartner(home_node, traderoute)
		home_node.resource_list.erase(res_name)
		home_node.get_parent().add_child(traderoute)

		queue_free()

func _on_static_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
		if event.is_action_pressed("mb_left") &&  home_node.node_owner == "player":
			is_held = true

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("locations")&& body != home_node:
		on_node = true
		target_node = body

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("locations") && body != home_node:
		on_node = false
		target_node = null
