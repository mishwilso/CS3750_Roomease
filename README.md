# CS3750_Roomease Deliverable #2

We have also implemented the functionality of moving through the different screens of the app, which is a tab view at the bottom of the screen.
Application Dependencies
Libraries and dependencies that are required to run the application include the following:
- FirebaseCore
- FirebaseAuth
- FirebaseFirestore

We installed these using Swift Package Manager. FirebaseCore is automatically included when installing firebase-ios-sdk but you have to manually choose to add FirebaseAuth and FirebaseFirestore.

Use the following link when adding the Firebase SDK: https://github.com/firebase/firebase-ios-sdk


## Learning
A significant amount of time of the first deliverable was spent on learning how to use Google Firebase, our backend for this app, and SwiftUI. For Firebase, a lot of time was spent reading documentation and watching tutorial videos, but we feel that we have a better grasp on the different services (Firebase Authentication & Firestore) that we plan to use for this project. We created a Firestore database under Daniel Kelley’s google account, and we are listing every attribute of each user under a unique id for each user that is created when the user registers for the app. We also learned about the process of adding libraries to a SwiftUI project and integrating them in the code. Our app now sends the data of new users to our database in Firebase, and we are working on having it store more user information from the app.

While Anthony and Dan worked on the backend, Mish, Emma and Molly worked on implementing the front-end of the app. There was a lot of configuration with understanding Navigation Views and learning about the features Swift UI had to offer. So far we managed to get the bones of the front-end set up and we’re hoping to connect it all with the back-end in the next delivery.


## Login & Registration Views
When the user first opens the application, they will be brought to the We have begun to implement the login/registration pages. The user can log into their current account or create a new one. All user accounts are managed by Firebase Authentication. When the user creates a new account they will be prompted to enter a house id. Currently the Create House and Join House aren’t fully implemented with the database, so you’re allowed to enter any code to bypass this page.

The Login and Registration screen has some input validation in place. Ensuring that none of the fields are empty and also telling the user whether or not their registration was successful. By the next deliverable we’re hoping to put password strength verification as well as ensuring the user doesn’t put in continuous spaces. (Among other things)


## Navigation and Calendar
Implemented the functionality of out Navigation Screen. The only screens with function are Calender, Chores and Grocery while the remaining screens have a Temporary Work-In-Progress Screen.

We have started to implement the calendar page of the app. You can select different days and transition through the different months. It has both a Month View and a Week View. However, we have not yet implemented the functionality of adding certain events to each of the days yet, but that information will be stored in our Firestore database. 


## Chores View
We have started to implement the chores/tasks page. The page has a menu of each room in the house so that the chores and tasks can be organized. Each room contains a list of tasks that are appended by the user. Each task has a specific deadline that is also specified by the user. We have not yet implemented adding tasks, but task data will be stored and retrieved using Firestore.


## Groceries
We have started to implement the Groceries page as well. You have the ability to add the groceries to the list, as well as who the grocery is for. We’re hoping to implement the ability to choose what category of food it falls under in the next Deliverable. As of now, the information in the list doens’t always remain when you get off the screen since its not hooked to the database.
