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
	var ems: int
	func _init(_ems: int = 4):
		ems = _ems

	func unpack():
		var edit = LineEdit.new()
		edit.add_theme_constant_override("minimum_character_width", ems)
		return edit

class HBoxSlot:
	extends Slot
	var slots: Array
	func _init(_slots):
		slots = _slots

	func unpack():
		var hbox = HBoxContainer.new()
		for i in slots:
			hbox.add_child(i.unpack())
		return hbox
		
class AnnotatedEditSlot:
	extends HBoxSlot
	func _init(text):
		slots = [EditSlot.new(30), LabelSlot.new(text)]
		
class SpreadSlot:
	extends HBoxSlot

	class MiddleSlot:
		extends Slot
		func unpack():
			var middle = Control.new()
			middle.size_flags_horizontal |= Control.SIZE_EXPAND
			return middle
	
	func _init(left,right):
		slots = [left,MiddleSlot.new(),right]
	
class MarginSlot:
	extends Slot
	
	var width: float
	
	func _init(_width: float):
		width = _width
	
	func unpack():
		var margin = Control.new()
		margin.custom_minimum_size.x = width
		return margin
		
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
		[SpreadSlot.new(EditSlot.new(2),MarginSlot.new(30)),
		 SpreadSlot.new(EditSlot.new(2),MarginSlot.new(30))])
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
