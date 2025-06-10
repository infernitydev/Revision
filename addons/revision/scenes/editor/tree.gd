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

func _process(_delta: float):
	set_process_input(true)
	if selected_item:
		var preview = preload("res://addons/revision/scenes/editor/node_preview.tscn").instantiate()
		preview.get_node("Label").text = selected_item.get_text(0)
		force_drag(selected_item, preview)

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			selected_item = null

func drag_item(pos,button):
	if button == MOUSE_BUTTON_LEFT:
		selected_item = get_selected()
		var preview = Label.new()
		preview.text = selected_item.get_text(0)
		force_drag(selected_item, preview)
