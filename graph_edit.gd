class_name MPMapScriptGraph extends GraphEdit

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
