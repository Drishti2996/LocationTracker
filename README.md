# LocationTracker
Link for the demo of location tracker application: 
https://drive.google.com/file/d/1AcSrPtEnAFIkegPBjQHpWdKCdbq3oHpY/view?usp=sharing

"Location Tracker" is an app which tracks users location every 30 seconds or when user moves 200mts. 
 Please note, the application tracks your location in background too.
 The location with timeStamp is saved in a Database.
 The user is updated about the total uploads of data of that day and the time of the last upload in our DataBase 
 
 If user has traveled for 200mts, the 30 seconds time will restart calculating from 0 seconds.
 If user doesn't move or if user walks slowly, the user is updated about his location every 30 seconds and the distance is reset to 0mts once the location is shown to user.
 
 ### DataBase used:
##### The data is saved in aws cloud(RDS). (Please note currently the link to server is not added in the code to avoid huge aws billing.)
MySQL DataBase in AWS is used to store data. The API is a post API created using API gateway and Lambda function.

##### There is another functionality to save data in coreData. However, currently we are using AWS(RDS)

### Architecture:
CLEAN Architecture has been used in this application. In this, we have following components:
1. ViewController
2. Interactor
3. Presenter
4. Router
5. Interface
6. Configurator

VIEWCONTROLLER:
Handles view of the application. 

INTERACTOR:
All businness logic is implemented here. It includes API call or DB queires and manipulation of Data

PRESENTER:
Interactor passes data to presenter where it is manipulated according to the UI requirement.

ROUTER:
It routes from one screen to another.

CONFIGURATOR:
It configures viewcontroller, presenter, interactor and router.

INTERFACE:
It has all the protocols needed for the architecture.

### FUTURE SCOPE
1. Improve Unit Test Coverage
2. UI Test Cases
3. Language Handler to handle multiple languages


