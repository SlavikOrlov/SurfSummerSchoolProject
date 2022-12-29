# SurfSummerSchoolProject

## About
The Gallery application in which the user must register, after which he can see a collection of cards. We can also save cards to favorites, search and see detailed information about each. On the profile screen, we can log out of the account.

[Design](https://www.figma.com/file/DskQkoBqXewHFzyqlKkao3/Surf-education-iOS?node-id=13%3A9067)

## Application Structure
1. LaunchScreen
2. Registration
    * Login "+7 (987) 654 32 19"
    * Password: "qwerty"
3. TabBar
    * Main
    * Detail
    * Favorite
    * Profile
4. Search

## Stack
* UIKit

## Start
1. Run the project
2. Authorization
    * Login "+7 (987) 654 32 19"
    * Password: "qwerty"
3. Click on the searchIcon on the navigationBar and select the sort option
4. On the Profile, by clicking on the logOut, you can exit to the Registration

## Implementation details:
- [X] RegistrationViewController. Added error message with incorrect login/password and extensions keyboard.
- [X] WalletViewController. UITableView with a list of cryptocurrencies. Cells store the names, price and changes per day.
- [X] SortViewController. UITableView with list sorting options: Drop in a day ↓ / Increase per day ↑
- [X] DetailInfoViewController. Under development.
- [X] ProfileViewController. "LogOut" outputs to the Registration.

## Tasks:
- [X] Initialized the application
- [X] Loaded project to the repository
- [X] Organized main screens
- [X] Created NavigationBar, search button with clicking
- [X] Created main screen
- [X] Initializing a search screen
- [X] Made a transition to the screen by clicking on the search button
- [X] Created detail screen
- [X] Created detail screen
- [X] Created service layer
- [X] Added conditions (error, empty, loading)
- [X] Added caching data
- [X] Created service of saving to favorites with logic
- [X] Updating the project to the repository

## Screen
<img width="200" alt="Splash" src="https://user-images.githubusercontent.com/99760600/183309438-c7517d20-acc5-42f2-9cc3-3245496c4f02.jpg"> <img width="200" alt="Login focused" src="https://user-images.githubusercontent.com/99760600/183309441-18d726c1-a65e-4932-91ed-173a1b636c8a.jpg"> <img width="200" alt="Home" src="https://user-images.githubusercontent.com/99760600/183309493-51307961-9506-4283-9328-21b85c9114f6.jpg"> <img width="200" alt="Home more" src="https://user-images.githubusercontent.com/99760600/183309497-b1e7c390-2bf5-4892-b25b-ade7221e730f.jpg"> <img width="200" alt="Home loader" src="https://user-images.githubusercontent.com/99760600/183309502-87df5a1e-705f-4c81-ab4c-b836428cc817.jpg"> <img width="200" alt="Favorite" src="https://user-images.githubusercontent.com/99760600/183309507-00b72ff4-29c4-4b02-bcfa-06f6f2a072f1.jpg"> <img width="200" alt="Profile" src="https://user-images.githubusercontent.com/99760600/183309509-25cc6925-2492-4c7f-b7e9-41ffdddebe38.jpg">
