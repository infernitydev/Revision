class_name MPMapScriptGraph extends GraphEdit

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
			disconnect_node(from_node, from_port, to_node, to_port)
			return
	connect_node(from_node, from_port, to_node, to_port)

func disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("-- disconnection request --")
	print(from_node)
	print(from_port)
	print(to_node)
	print(to_port)
	disconnect_node(from_node, from_port, to_node, to_port)
