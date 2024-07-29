extends OptionButton


func _ready():
	# Adding items to the OptionButton
	self.add_item("Option 1")
	self.add_item("Option 3")
	self.add_item("Option 2")

	# Connect the "item_selected" signal to a custom function
	self.connect("item_selected", Callable(self, "_on_option_button_item_selected"))

func _on_option_button_item_selected(index):
	print("Selected option index: ", index)
	print("Selected option text: ", self.get_item_text(index))
