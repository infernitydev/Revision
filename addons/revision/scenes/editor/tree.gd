extends Tree

var selected_item = null

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
	item_mouse_selected.connect(drag_item)

func drag_item(pos,button):
	if button == MOUSE_BUTTON_LEFT:
		selected_item = get_selected()
		var preview = Label.new()
		preview.text = selected_item.get_text(0)
		force_drag(selected_item, preview)
		preview.tree_exited.connect(print.bind("Bye"))
		
#these are just for testing
func _can_drop_data(at_position: Vector2, data: Variant):
	return true

func _drop_data(at_position: Vector2, data: Variant):
	print("dropped")
	print(data)
