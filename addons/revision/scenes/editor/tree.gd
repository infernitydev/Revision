extends Tree

func _ready():
	var tree = self
	var root = tree.create_item()
	tree.hide_root = true
	var inputs = tree.create_item(root)
	inputs.set_text(0, "Inputs")
	var outputs = tree.create_item(root)
	outputs.set_text(0, "Outputs")
	var subchild1 = tree.create_item(inputs)
	subchild1.set_text(0, "Subchild1")
