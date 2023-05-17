extends Line2D

@onready var node_manager = get_node("/root/Game/World/NodeManager")
@onready var traderoute_panel = get_node("/root/Game/GUI/Main/Traderoute")
var resource_list: Dictionary

func _ready() -> void:
	node_manager.register_route(self)
	$Routes.position = (get_point_position(0) + get_point_position(1)) /2
	
func _process(_delta: float) -> void:
	$Routes.text = str(resource_list.size())

func set_positions(node1, node2):
	set_point_position(0,node1.global_position )
	set_point_position(1,node2.global_position )
	
func send_resource(target, resource):
	target.resource_list.append(resource)
	
func take_resource(target, resource):
	target.resource_list.erase(resource)
	
func set_route(id, origin, resource, target):
	resource_list[id] = [origin,resource, target]

func _input(event : InputEvent):
	if(event.is_action_pressed("mb_left")):
		var mouse_click : Vector2 = get_global_mouse_position()
		var squared_width : float = width*width
		var offset : float = 0
		for i in range(points.size()-1):
			var closest_point : Vector2 = Geometry2D.get_closest_point_to_segment(mouse_click, global_position + points[i], global_position + points[i+1])
			if closest_point.distance_squared_to(mouse_click) <= squared_width:
				offset += closest_point.distance_to(global_position + points[i])
				on_rightclick(i, mouse_click, offset)
				break
			else:
				offset += points[i].distance_to(points[i+1])
 
func on_rightclick(_segment : int, _global_position : Vector2, _offset : float) -> void:
	if !GlobalManager.panel_open:
		show_traderoute_panel()

func show_traderoute_panel():
	GlobalManager.panel_open = true
	traderoute_panel.show()
	update_traderoute_panel()
	
func update_traderoute_panel():
	traderoute_panel.create_routes(self,resource_list)

func time_passed():
	GlobalManager.total_value += 10
	print (GlobalManager.total_value)
	pass
