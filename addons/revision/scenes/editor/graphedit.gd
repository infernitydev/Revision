class_name RevisionScriptGraph extends GraphEdit

var NodeData = RevisionScriptNodeData.new()

func _ready() -> void:
	var hbox = get_menu_hbox()
	for item in hbox.get_children():
		if item is Control:
			match item.tooltip_text:
				"Toggle the visual grid.":
					item.hide()
				"Change the snapping distance.":
					item.tooltip_text = "Change the grid distance."
					item.step = 10
					item.min_value = 10
					item.max_value = 40
					item.suffix = "px"
				_:
					pass

func connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("-- connection request --")
	print(from_node)
	print(from_port)
	print(to_node)
	print(to_port)
	for con in get_connection_list():
		if con.to_node == to_node and con.to_port == to_port:
			print("disconnecting")
			disconnect_node(con.from_node, con.from_port, to_node, to_port)
	connect_node(from_node, from_port, to_node, to_port)

func disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("-- disconnection request --")
	print(from_node)
	print(from_port)
	print(to_node)
	print(to_port)
	disconnect_node(from_node, from_port, to_node, to_port)

func create_node(position: Vector2, type: String):
	var node = GraphNode.new()
	var node_data = NodeData.nodes[type]
	node.title = node_data.title
	var more_outputs = len(node_data.outputs) > len(node_data.inputs)
	var greater = len(node_data.outputs) if more_outputs else len(node_data.inputs)
	for idx in greater:
		var slot
		if idx < len(node_data.slots):
			slot = node_data.slots[idx].unpack()
		else:
			slot = Control.new()
			slot.custom_minimum_size.y = 10
		node.add_child(slot)
		if idx >= len(node_data.inputs):
			var output = node_data.outputs[idx]
			node.set_slot(idx,false,0,Color.WHITE,true,output.type,output.color)
		elif idx >= len(node_data.outputs):
			var input = node_data.inputs[idx]
			node.set_slot(idx,true,input.type,input.color,false,0,Color.WHITE)
		else:
			var input = node_data.inputs[idx]
			var output = node_data.outputs[idx]
			node.set_slot(idx,true,input.type,input.color,true,output.type,output.color)
	for idx in max(0, len(node_data.slots)-greater):
		var slot = node_data.slots[idx].instantiate()
		node.add_child(slot)
	var snapped_position = (position.snapped(Vector2(snapping_distance,snapping_distance))
							if snapping_enabled else position)
	node.position_offset = (snapped_position + scroll_offset) / zoom
	add_child(node)
	node.owner = self

func _can_drop_data(at_position: Vector2, data: Variant):
	return data is TreeItem

func _drop_data(at_position: Vector2, data: Variant):
	data = data as TreeItem
	create_node(at_position, data.get_text(0))
