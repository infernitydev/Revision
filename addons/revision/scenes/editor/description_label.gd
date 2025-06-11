extends RichTextLabel

@onready var NodeTree = get_node("../..").find_child("Tree")

func _on_tree_item_selected() -> void:
	var item = NodeTree.get_selected()
	var node_data = NodeTree.NodeData.nodes.get(item.get_text(0))
	if node_data:
		text = node_data.description
	else:
		text = ""
