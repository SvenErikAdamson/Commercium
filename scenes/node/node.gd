extends StaticBody2D

@onready var node_manager = get_node("/root/Game/World/NodeManager")
@onready var connector_scene = preload("res://scenes/node/connector.tscn")
@onready var resource_scene = preload("res://scenes/eco/resource.tscn")
@export var resource_list: Array
@export var node_name: String
@export var node_owner: String

var tradepartners: Dictionary
var connector_there: bool = false

func _ready():
	node_manager.register_node(self)
	$NodeName.text = node_name
	draw_resources()

func set_tradepartner(partner, route):
	tradepartners[partner] = route

func draw_resources() -> void:
	for i in $Resources.get_children():
		i.queue_free()
		
	var offset = 0
	for j in resource_list:
		var resource = resource_scene.instantiate()
		resource.home_node = self
		match j:
			"toit":
				resource.value = 10
				resource.res_name = "toit"
			"vesi":
				resource.value = 5
				resource.res_name = "vesi"
				
		resource.position.x = position.x -50 + offset
		resource.position.y = position.y + 65
		offset += 50
		$Resources.add_child(resource)
		
func time_passed():
	pass
