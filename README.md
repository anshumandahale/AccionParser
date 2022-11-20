#  Skills utilized:

- Coordinator Pattern
> I have removed the Storyboards completely and have used the coordinator for Navigation in the app.
> VM is injected as a dependency in the VC by the Coordinator.
> ServiceClassObjects are injected as dependency in the VM objects. This is helpful in unit testing. We can pass MockService class objects to our VM now.

- MVVM pattern
> Both the VC's have a associated VM. They communicate with each other by the protocol delegate pattern.

- Unit test cases
> I have written test cases to test the business logic in our VM's.

# Working
- The first VC shows the list of all the user's. It displays there name and DP in the cell. I have used Kingfisher library to load images from the links.
- When user taps any cell app navigates to details VC where the User tags are shown.
- Network class executes the request and performs remote action.
>It accepts a Model object and returns the parsed model to the service class.
>Requester class is used to create request. Here we can set required headers and timeouts for our request.

# Improvements
- We can use the R.generator library to get rid of all magic strings in the project.
  

