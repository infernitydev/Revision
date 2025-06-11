extends Object
class_name RevisionScriptNodeData

enum builtin_types {
	NUMBER = 0,
	STRING = 1,
	LIST = 2
}

class Port:
	var type
	var color
	
	var types = [
		{name="NUMBER", color=Color(0.4,0.6,0.8)},
		{name="STRING", color=Color(0.8,0.4,0.4)},
		{name="LIST", color=Color(0.6,0.8,0.4)}
	]

	func _init(_type: int):
		type = _type
		color = types[_type].color

class Slot:
	func unpack():
		pass
		
class LabelSlot:
	extends Slot
	var text: String
	func _init(_text: String):
		text = _text

	func unpack():
		var label = Label.new()
		label.text = text
		return label

class SceneSlot:
	extends Slot
	var scene: PackedScene
	func _init(_scene: PackedScene):
		scene = _scene

	func unpack():
		return scene.instantiate()
		
class EditSlot:
	extends Slot
	func unpack():
		var edit = LineEdit.new()
		return edit

var nodes = {
	"Number": RevisionScriptNode.new(
		"  Number  ", 
		"[b]Number[/b]\n[indent]A constant number.",
		[],
		[Port.new(builtin_types.NUMBER)],
		[EditSlot.new()]),

	"String": RevisionScriptNode.new(
		"   String   ", 
		"[b]String[/b]\n[indent]A constant string.",
		[],
		[Port.new(builtin_types.STRING)],
		[EditSlot.new()]),
		
	"Add": RevisionScriptNode.new(
		"  Add  ", 
		"[b]Add[/b]\n[indent]Add two values.",
		[Port.new(builtin_types.NUMBER), Port.new(builtin_types.NUMBER)],
		[Port.new(builtin_types.NUMBER)],
		[])
}

var tree = {
	"Inputs": {},
	"Constants": {
		"Number": nodes.Number,
		"String": nodes.String
	},
	"Calculation": {
		"Add": nodes.Add
	},
	"Outputs": {}
}
