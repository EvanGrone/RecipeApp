```
Software Engineering - CIS 350
```
<p align="center">
  <img src="Images/recipe_book.jpg" width="400" title="RECIPE BOOK">
</p>

# **Recipe Coordinator**
## Created by: 
---
### Group 1:
#### Gabe Baksa
#### Evan Gronewald 
#### Caleb Kipp
---
___
## 1. Abstract
This abstract presents a mobile application designed to revolutionize cooking experiences by efficiently matching user-input ingredients to a vast recipe database. The app matches input to pair available ingredients with suitable recipes. The system prioritizes user convenience and engagement by offering personalized recipe recommendations based on the ingredients at hand. Through an intuitive and user-friendly interface, this mobile app streamlines the process of meal planning, reducing food waste, and enabling users to create diverse and delicious dishes effortlessly. The app's innovation lies in its ability to adapt to user preferences and available ingredients while presenting an accessible and enjoyable culinary exploration for users of all skill levels. This mobile application stands at the forefront of simplifying cooking experiences, promoting sustainable practices, and enhancing culinary creativity.
___
## 2. Introduction
In an era where culinary exploration and meal planning intersect with technology, our mobile application emerges as a groundbreaking solution to streamline the cooking process. The app represents an innovative and user-centric approach to simplify the often daunting task of deciding what to cook based on available ingredients. The inspiration behind this app stems from the common challenge many individuals face: standing in front of a pantry or refrigerator, uncertain of what to prepare with the ingredients on hand. With the vision to empower users and revolutionize their cooking experiences, our team set out to develop a mobile application that not only addresses this challenge but also encourages culinary creativity. This introduction marks the inception of a mobile app that is more than just a recipe database. It represents a system that understands available ingredients to offer tailored recipe suggestions. By prioritizing user convenience, this app seeks to transform cooking into an enjoyable and efficient endeavor for users of all culinary skill levels.
## 3. Architectural Design
Our App works with a client-server architecture. The client is given an interactive iOS-based user interface for sorting through ingredients they have and finding recipes that match those ingredients. The server-side processing will be held in Firebase. The client requests the server with their list of ingredients and the server will respond with a recipe that matches those ingredients.

<p align="center">
  <img src="UpdatedArchitecture.jpg" width="500" title="architecture">
  <br>
  <br>
  Figure 1: Client Server Architecture of RecipeFinder App
</p>

### 3.1 Class Diagram
![Class.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/Recipe%20Class%20Diagram.png)
This section contains the class diagram for the recipe app, showing the boundary class "Recipe" that the user interacts with, the enity class "Database" that stores the recipe data, and the control class "Finder" that finds the recipe and another boundary class "UserIngredients that allows the user to edit the ingredients that they have.
### 3.2 Use Case Diagram
![Case.png](https://github.com/EvanGrone/RecipeApp/blob/main/Check%202%20Use%20Case.png)
The use case diagram for our RecipeFinder App shows the main purpose of our app, which is that once given ingredients by the user, our app accesses a database of recipes and outputs a single recipe for the user.
### 3.3 Sequence Diagram
![Sequence.png](https://github.com/EvanGrone/RecipeApp/blob/main/Check%202%20Sequence.png)
This section shows the sequence diagram for our RecipeFinder App. Initially, a user interface is loaded and the user is asked to select ingredients. Once the ingredients are selected, the app checks for a recipe in the database to match the ingredients. If there is one, the recipe is outputted, otherwise the user is asked to try again.
### 3.4 Activity Diagram
![Activity Diagram.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/Recipe%20Activity%20Diagram.png)

## 4. User Guide / Implementation
### 4.1 Client
![UI Dropdown.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/UIdropdown.png)
![UI Matching.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/UImatching.png)
![UI SC.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/UIsc.png)

Above we have our different UIs. Above you can see the drop down to choose an ingredient with the output of the recipe. Other than the drop down, there are only two clickable buttons, as to keep the app simplistic. There is a "remove" button, which as it sounds removes the ingredient from the list. Then there is the "Go!" button which starts the process in outputting what recipes you can make.
### 4.2 Server
![FirebaseServer.png](https://github.com/EvanGrone/RecipeApp/blob/main/Images/FirebaseServer.png)

Above you can see our real time database using firebase. It uses a dictionary format to make pulling values simplistic. The databse can be accessed from any computer using the app from a centralized location.
## 5. Future Scope
There are lots of ways in which the RecipeFinder App could be further developed if more time was available. Using a larger set of data would be useful for users because it would give more recipe options available to match with. Also, adding machine learning to the app would be beneficial. If a like and dislike button were added, then the system could learn what recipes the user seems to enjoy or even what is popular and take that into account when outputting a recipe.  
## 6. Conclusion
Overall, our RecipeFinder App would be very beneficial for many reasons. It saves its users time deciding by instantly outputting a possible option of something to make. Our app reduces food waste by giving users ideas of what to use their ingredients for. These are just a few reasons why our RecipeApp would be useful, but there are still many ways in which our app could be improved to even further benefit its users.
## 7. Walkthrough

[Firebase Project Link](https://console.firebase.google.com/u/0/project/recipeapp-98710/overview?utm_source=welcome&utm_medium=email&utm_campaign=welcome_2021_CTA_A)

