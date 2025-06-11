extends Tree

var NodeData = RevisionScriptNodeData.new()

var selected_item = null

func _ready():
	var tree = self
	var root = tree.create_item()
	tree.hide_root = true
	for item in NodeData.tree:
		add_item(root,item,NodeData.tree[item])
	item_mouse_selected.connect(select_item)
	
func add_item(parent,item,item_data):
	var tree_item = create_item(parent)
	tree_item.set_text(0, item)
	if item_data is Dictionary:
		for i in item_data:
			add_item(tree_item, i, item_data[i])

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

func select_item(pos,button):
	if button == MOUSE_BUTTON_LEFT:
		var item = get_selected()
		if item.get_text(0) in NodeData.nodes:
			selected_item = item
			var preview = Label.new()
			preview.text = selected_item.get_text(0)
			force_drag(selected_item, preview)
