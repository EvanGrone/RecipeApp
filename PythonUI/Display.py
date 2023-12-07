import wx


class IngredientsApp(wx.Frame):
    def __init__(self):
        super(IngredientsApp, self).__init__(None, wx.ID_ANY, "Ingredients App", size=(400, 300))

        self.ingredients = ['Ingredient 1', 'Ingredient 2', 'Ingredient 3', 'Ingredient 4']  # List of ingredients
        self.selected_ingredients = []  # list of selected ingredients we can iterate through to match for the recipe

        panel = wx.Panel(self)
        # creates a dropdown with the choices of our ingredients
        self.dropdown = wx.Choice(panel, wx.ID_ANY, choices=self.ingredients, pos=(10, 10))
        # creates a button that after selecting the ingredient adds it to the list of ingredients
        self.add_button = wx.Button(panel, label="Add", pos=(150, 8))
        # Button for removing the ingredients we have added
        self.remove_button = wx.Button(panel, label="Remove", pos=(250, 8))
        # button for searching and matching recipe with ingredients selected
        self.go_button = wx.Button(panel, label="GO!", pos=(300, 100))

        self.ingredients_listbox = wx.ListBox(panel, choices=[], pos=(10, 50), size=(150, 200))

        # Binding button to wx EVT BUTTON 
        self.add_button.Bind(wx.EVT_BUTTON, self.on_add)
        self.remove_button.Bind(wx.EVT_BUTTON, self.on_remove)
        self.go_button.Bind(wx.EVT_BUTTON, self.on_go)

        self.update_dropdown()

    def on_add(self, event):
        # Function that on click, selects that ingredient to be added when we click add button
        # GetSelection() is built-in wx method that allows selection
        selected_index = self.dropdown.GetSelection()
        if selected_index != wx.NOT_FOUND: # Selected index will be what user clicks for event
            selected_ingredient = self.ingredients[selected_index]
            self.selected_ingredients.append(selected_ingredient)
            self.ingredients.pop(selected_index) # pop() method to remove what is selected
            self.update_dropdown()
            self.update_ingredients_listbox()

    def on_remove(self, event):
        # On click, function removes last ingredient added into the list of ingredients we want to use
        if self.selected_ingredients:
            removed_ingredient = self.selected_ingredients.pop()
            self.ingredients.append(removed_ingredient)
            self.update_dropdown()
            self.update_ingredients_listbox()

    def on_go(self, event):
        # Perform matching process with the selected ingredients list
        # If no ingredients are selected, populate message that you need ingredients
        if self.selected_ingredients:
            wx.MessageBox(f"Matching process initiated with ingredients: {', '.join(self.selected_ingredients)}",
                          "Matching", wx.OK | wx.ICON_INFORMATION)
        else:
            wx.MessageBox("No ingredients selected.", "Info", wx.OK | wx.ICON_INFORMATION)

    def update_dropdown(self):
        self.dropdown.Set(self.ingredients)

    def update_ingredients_listbox(self):
        self.ingredients_listbox.Set(self.selected_ingredients)
